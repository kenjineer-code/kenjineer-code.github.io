#!/bin/bash
# Dependency-free (bash + awk/grep only) verifier for _data/locales.yml
# and the files/anchors/footers it references.
# Run from repo root: bash scripts/check-privacy-locales.sh

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCALES_YML="$REPO_ROOT/_data/locales.yml"
LEGAL_META_YML="$REPO_ROOT/_data/legal_meta.yml"
SITE_DIR="$REPO_ROOT/_site"
TMP_PUBLISHED="$(mktemp)"
trap 'rm -f "$TMP_PUBLISHED"' EXIT

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

[ -f "$LOCALES_YML" ] || fail "_data/locales.yml not found at $LOCALES_YML"
[ -f "$LEGAL_META_YML" ] || fail "_data/legal_meta.yml not found at $LEGAL_META_YML"
[ -d "$SITE_DIR" ] || fail "_site not found — run 'jekyll build' from repo root before this checker"

get_meta_value() {
  key="$1"
  grep "^${key}:" "$LEGAL_META_YML" | sed -E 's/^[a-zA-Z_]+: *"?([^"]*)"?$/\1/'
}

# get_meta_nested reads a per-locale value from a *specific* top-level section
# of _data/legal_meta.yml (e.g. `last_updated_display`, `version_label`,
# `last_updated_label`). It is section-scoped (unlike a bare grep for
# "^  <locale>: ") because multiple sections share the same 2-space-indented
# "<locale>: ..." shape; an unscoped grep would match the same locale under
# every section and silently return several concatenated values.
get_meta_nested() {
  section="$1"
  locale="$2"
  awk -v section="$section" -v locale="$locale" '
    /^[a-zA-Z_]+:/ { cur=$0; sub(/:.*/, "", cur) }
    cur == section && $0 ~ ("^  " locale ": ") {
      line=$0
      sub(/^ *[a-zA-Z_-]+: *"?/, "", line)
      sub(/"?$/, "", line)
      print line
      exit
    }
  ' "$LEGAL_META_YML"
}

VERSION="$(get_meta_value version)"
[ -n "$VERSION" ] || fail "_data/legal_meta.yml has no 'version' value"

extract_entries() {
  section="$1"
  awk -v section="$section" '
    function emit() { if (locale != "") { print locale "|" url "|" label; locale=""; url=""; label="" } }
    /^published:/ { emit(); cur="published"; next }
    /^planned:/   { emit(); cur="planned"; next }
    /^[a-zA-Z]/   { emit(); cur=""; next }
    cur == section && /^ *- locale:/ {
      emit()
      loc=$0; sub(/^.*- locale: */, "", loc); locale=loc
    }
    cur == section && /^ *url:/ {
      u=$0; sub(/^.*url: */, "", u); url=u
    }
    cur == section && /^ *label:/ {
      l=$0; sub(/^.*label: */, "", l); label=l
    }
    END { emit() }
  ' "$LOCALES_YML"
}

extract_entries published > "$TMP_PUBLISHED"

[ -s "$TMP_PUBLISHED" ] || fail "published list is empty in _data/locales.yml"

# (e) published must contain a locale: en entry (required as the case-3 English fallback target).
awk -F'|' '{print $1}' "$TMP_PUBLISHED" | grep -qx "en" \
  || fail "published must contain a 'locale: en' entry (required as the case-3 fallback target)"

# (a) each published entry's url, with any #fragment stripped, must point to an existing file.
# (a-2) if the url has a #fragment, the corresponding id="..." must exist inside that file.
# (b) the BUILT output's footer version/date must match _data/legal_meta.yml (single source of truth).
while IFS='|' read -r locale url label; do
  file="${url%%#*}"
  [ -f "$REPO_ROOT/$file" ] || fail "published locale '$locale' -> url '$url' -> file '$file' does not exist"
  case "$url" in
    *#*)
      fragment="${url#*#}"
      grep -q "id=\"${fragment}\"" "$REPO_ROOT/$file" \
        || fail "published locale '$locale' -> url '$url' -> anchor id=\"$fragment\" not found in '$file'"
      ;;
  esac

  built_file="$SITE_DIR/$file"
  [ -f "$built_file" ] || fail "built output '$built_file' not found for locale '$locale' — run 'jekyll build' first"

  display="$(get_meta_nested last_updated_display "$locale")"
  [ -n "$display" ] || fail "_data/legal_meta.yml has no last_updated_display.$locale entry (needed for published locale '$locale')"

  version_label="$(get_meta_nested version_label "$locale")"
  [ -n "$version_label" ] || fail "_data/legal_meta.yml has no version_label.$locale entry (needed for published locale '$locale')"
  grep -qF "${version_label} ${VERSION}" "$built_file" \
    || fail "built '$file' does not contain expected '${version_label} ${VERSION}' for locale '$locale' (footer/data drift)"

  last_updated_label="$(get_meta_nested last_updated_label "$locale")"
  [ -n "$last_updated_label" ] || fail "_data/legal_meta.yml has no last_updated_label.$locale entry (needed for published locale '$locale')"
  grep -qF "${last_updated_label}${display}" "$built_file" \
    || fail "built '$file' does not contain expected '${last_updated_label}${display}' for locale '$locale' (footer/data drift)"

  # (c) the switcher rendered in this built file must link to exactly the published urls (no more, no less, no drift).
  switcher_line="$(grep -o '<div class="lang-switcher">.*</div>' "$built_file" | head -n1)"
  [ -n "$switcher_line" ] || fail "lang-switcher not found in built '$file'"
  switcher_hrefs="$(printf '%s\n' "$switcher_line" | grep -oE 'href="[^"]+"' | sed -E 's/^href="(.*)"$/\1/' | sort)"
  published_urls="$(awk -F'|' '{print $2}' "$TMP_PUBLISHED" | sort)"
  [ "$switcher_hrefs" = "$published_urls" ] \
    || fail "built '$file' switcher hrefs [$switcher_hrefs] do not exactly match published urls [$published_urls]"

  # (g) every published entry must have a non-empty 'label' in _data/locales.yml, and that
  #     label text must actually appear in the rendered switcher (guards against a silently
  #     blank switcher link when the now fully data-driven lang-switcher.html include is fed
  #     an entry with a missing label).
  [ -n "$label" ] || fail "published locale '$locale' has no 'label' in _data/locales.yml (required for switcher display)"
  printf '%s\n' "$switcher_line" | grep -qF ">${label}<" \
    || fail "built '$file' switcher does not contain label '$label' for locale '$locale' (rendered: $switcher_line)"

  # (h) html lang attribute: the hub file (privacy.html) always renders lang="ja" regardless
  #     of which published locale entry (ja or en) points at it, because ja/en intentionally
  #     share one document with no 'locale' front matter (see _layouts/legal.html default).
  #     A dedicated per-locale file (e.g. privacy.es.html) must set 'locale: <code>' in its
  #     front matter and render lang="<code>".
  if [ "$file" = "privacy.html" ]; then
    expected_lang="ja"
  else
    expected_lang="$locale"
  fi
  grep -qF "<html lang=\"${expected_lang}\">" "$built_file" \
    || fail "built '$file' does not have expected <html lang=\"${expected_lang}\"> for locale '$locale'"

  # (d) the redirect JS's PUBLISHED_LOCALES map keys must exactly match published locale codes
  #     (case-sensitive, no aliasing), and must never contain known pt-BR look-alikes.
  map_keys="$(grep -oE '^    "[^"]+": "' "$built_file" | sed -E 's/^    "([^"]+)": "$/\1/' | sort)"
  [ -n "$map_keys" ] || fail "PUBLISHED_LOCALES map not found (or empty) in built '$file'"
  published_locales="$(awk -F'|' '{print $1}' "$TMP_PUBLISHED" | sort)"
  [ "$map_keys" = "$published_locales" ] \
    || fail "built '$file' PUBLISHED_LOCALES map keys [$map_keys] do not exactly match published locales [$published_locales]"
  for alias in pt pt-PT pt_BR pt-br PT-BR; do
    printf '%s\n' "$map_keys" | grep -qx "$alias" \
      && fail "built '$file' PUBLISHED_LOCALES map must not contain pt-BR look-alike key '$alias'"
  done

  # (f) the redirect JS must check langValues.length === 0 (absent -> no-op) BEFORE it checks
  #     length === 1 (single-value match). Checking length !== 1 first would misclassify the
  #     absent case as unsupported and redirect on bare privacy.html loads (Round 5 regression).
  line_absent="$(grep -n 'langValues\.length === 0' "$built_file" | head -n1 | cut -d: -f1)"
  line_single="$(grep -n 'langValues\.length === 1' "$built_file" | head -n1 | cut -d: -f1)"
  [ -n "$line_absent" ] || fail "built '$file' has no 'langValues.length === 0' branch"
  [ -n "$line_single" ] || fail "built '$file' has no 'langValues.length === 1' branch"
  [ "$line_absent" -lt "$line_single" ] \
    || fail "built '$file' checks langValues.length === 1 (line $line_single) before === 0 (line $line_absent) — violates required evaluation order (absent must be checked first)"
done < "$TMP_PUBLISHED"

echo "OK: all checks passed"
