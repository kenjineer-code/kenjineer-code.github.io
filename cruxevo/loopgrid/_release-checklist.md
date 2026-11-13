# Cruxevo: Fences Android legal release checklist

Created 2026-11-13. Internal file: the leading underscore excludes it from Jekyll page generation. Publishing these documents is not app-release or legal-compliance evidence.

## Routes

- Directory: `cruxevo/loopgrid/`, derived from `cruxevo/bridgegrid/` (owner, 2026-11-13: copy the earlier app's legal texts and change the app name).
- `index.html`, `privacy.html` / `terms.html` (English first, Japanese at `#ja`), and `privacy.<locale>.html` / `terms.<locale>.html` for zh-Hant, es, de, fr, pt-BR, ko, it. `language.js` and `legal.css` are unchanged copies.
- Public routes: `https://kenjineer-code.github.io/cruxevo/loopgrid/privacy.html` and `/terms.html`.

## Source of truth

- App repository `kenjineer-code/loop_grid`, `assets/legal/*.json` (App issue #11). Terms v1 2026-10-04, privacy v3 2026-10-12, the same versions as the earlier Cruxevo apps.
- The pages differ from `cruxevo/bridgegrid/` only in the app name, the rules-ownership sentence (Slitherlink, the one place the general puzzle name appears), the stored-data sentence (drawn lines and crosses), the landing-page description, and the Korean particle after the new name.
- Titles: English Cruxevo: Fences; Japanese Cruxevo：囲いパズル; Korean Cruxevo: 고리 퍼즐; Traditional Chinese Cruxevo: 數迴; French Cruxevo : Clôtures; German Cruxevo: Rundweg; Italian Cruxevo: Circuito Chiuso; Spanish and Portuguese (Brazil) Cruxevo: Cercas.
- Every app document line was checked against the page text (2026-11-13); the only differences are the list and link formatting that the earlier pages also show.

## Remaining

- [ ] Verify the deployed URLs, then register the privacy policy URL in Play Console and the AdMob GDPR message (app issue #13).
