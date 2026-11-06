# Cruxevo: Hashi Android legal release checklist

Created 2026-11-06. Internal file: the leading underscore excludes it from Jekyll page generation. Publishing these documents is not app-release or legal-compliance evidence.

## Routes

- Directory: `cruxevo/bridgegrid/`, derived from `cruxevo/lumengrid/` (owner: the series follows the earlier apps).
- `index.html`, `privacy.html` / `terms.html` (English first, Japanese at `#ja`), and `privacy.<locale>.html` / `terms.<locale>.html` for zh-Hant, es, de, fr, pt-BR, ko, it. `language.js` and `legal.css` are unchanged copies.
- Public routes: `https://kenjineer-code.github.io/cruxevo/bridgegrid/privacy.html` and `/terms.html`.

## Source of truth

- App repository `kenjineer-code/bridge_grid`, `assets/legal/*.json` (App issue #11). Terms v1 2026-10-04, privacy v3 2026-10-12, the same versions as the earlier Cruxevo apps.
- The pages differ from `cruxevo/lumengrid/` only in the app name, the rules-ownership sentence (Hashi / Bridges), the stored-data sentence (placed bridges and crosses), the landing-page description, and the French product name `Cruxevo : Hashi` (owner decision 2026-11-06).
- Titles: Japanese Cruxevo：橋かけパズル; Korean Cruxevo: 하시; Traditional Chinese Cruxevo: 數橋; French Cruxevo : Hashi; all other languages Cruxevo: Hashi.
- Every app document line was checked against the page text (2026-11-06); the only differences are the list and link formatting that the Lumen Grid pages also show.

## Remaining

- [ ] Verify the deployed URLs, then register the privacy policy URL in Play Console and the AdMob GDPR message (app issue #13).
