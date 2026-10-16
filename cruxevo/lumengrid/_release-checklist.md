# Cruxevo: Lumen Grid Android legal release checklist

Created 2026-10-16. Internal file: the leading underscore excludes it from Jekyll page generation. Public HTML describes the current implementation. Publishing these documents is not app-release or legal-compliance evidence.

## Routes

- Directory: `cruxevo/lumengrid/`, copied from `cruxevo/nanpure/` (owner: everything follows the Sudoku app).
- `index.html`: app-specific legal landing page.
- `privacy.html` / `terms.html`: English first, Japanese at `#ja`.
- `privacy.<locale>.html` / `terms.<locale>.html`: zh-Hant, es, de, fr, pt-BR, ko, it. Italian is generated from the app's `assets/legal/it.json`; `cruxevo/nanpure/` has no Italian pages.
- `language.js`: allowlisted `?lang=` routes with English fallback, including `it`.
- Public routes: `https://kenjineer-code.github.io/cruxevo/lumengrid/privacy.html` and `/terms.html`.

## Source of truth

- App repository `kenjineer-code/lumen_grid`, `assets/legal/*.json` (owner-approved Japanese in issue #12; translations in PR #127). Terms v1 2026-10-04, privacy v3 2026-10-12, the same versions as the Sudoku app.
- The pages differ from `cruxevo/nanpure/` only in the app name, the rules-ownership sentence (Akari / Light Up), the stored-data sentence (placed bulbs and crosses), the landing-page description, and the Italian pages and links.
- Owner-approved titles (2026-10-16, App #128): Japanese Cruxevo: 光のロジック; Korean Cruxevo: 빛의 논리; Traditional Chinese Cruxevo: 光之邏輯; all other languages Cruxevo: Lumen Grid. Title-only updates preserve the document versions and substantive terms.
- Every app document line was checked to appear in the matching page text (2026-10-16).

## Remaining

- [ ] The shared legal and operational gates in `cruxevo/nanpure/_release-checklist.md` apply equally to this app.
- [ ] Verify the deployed URLs, then register the privacy policy URL and declarations in Play Console (app issue #17).
