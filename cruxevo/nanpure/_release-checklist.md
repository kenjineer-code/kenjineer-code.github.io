# Cruxevo Android legal release checklist

Created 2026-10-04. Internal file: leading underscore excludes this from normal Jekyll page generation. Public HTML describes the current implementation. Publishing these documents is not app-release or legal-compliance evidence.

## Routes

- Directory: `cruxevo/nanpure/`
- `index.html`: app-specific legal landing page.
- `privacy.html`: English first, Japanese at `#ja`.
- `terms.html`: English first, Japanese at `#ja`.
- `legal.css`: local styles; no analytics, remote fonts, or tracking added.
- `language.js`: allowlisted app-specific `?lang=` routes with English fallback. Explicit language links work without JavaScript.
- `privacy.<locale>.html` and `terms.<locale>.html`: zh-Hant, es, de, fr, pt-BR, ko. English and Japanese use anchors on the base documents.
- Public routes after deployment verification: `https://kenjineer-code.github.io/cruxevo/nanpure/privacy.html` and `/terms.html`. GitHub Pages API on 2026-10-04 reports public legacy Pages, main root, no custom domain, HTTPS enforced.

These files intentionally do not use `_layouts/legal.html`, the predecessor's locale routing, or its shared legal version. Do not redirect Cruxevo's `?lang` requests into Nova's policy.

## Evidence used

- App `docs/spec/00_product_overview.md`: offline, no accounts, eight release languages (not yet implemented).
- App `docs/spec/03_coin_economy.md`: local coins/upgrades, optional rewarded ads and interstitials.
- App `lib/core/ads/child_directed_ads.dart`: child-directed treatment and G maximum for everyone.
- App `android/app/src/main/AndroidManifest.xml`: advertising-ID/AdServices permissions removed; no explicit backup exclusion; test AdMob application ID remains.
- App `docs/reports/2026-10-04-android-release-readiness.md`: receipt/discard and legal links implemented; consent, Play-distributed receipt checks and production settings unfinished.
- App `CruxevoApplication` / `AgeSignalsReceiver`: process-owned once guard; shared-only retrieval; native payload discarded without reading fields or forwarding to Dart.
- Site `index.html`: public business name, address, support email.

## Remaining app-release and legal-operational gates

- [ ] Confirm responsible legal operator identity and whether the public studio name is sufficient for each target market; assess required EEA/UK representatives. Do not infer exemptions based on studio size.
- [ ] Resolve mixed-age/no-age-entry Families alignment, COPPA consent or applicable exceptions, and EEA/UK/Swiss consent handling. G-rated ads alone are not proof of compliance.
- [ ] Verify the actual pinned native Mobile Ads SDK, production ad sources and mediation, child-directed identifier behavior, data recipients, retention and processing purposes. Google's latest-version SDK summary is not proof for every build.
- [ ] Verify startup ordering and release traffic, including native initialization before Dart safeguards. No device tests or builds were run for these documents.
- [ ] Decide Android backup/restore/deletion behavior and align the release manifest and privacy wording. Do not say all data always stays on one device or all backup copies disappear on uninstall.
- [x] Implement Play Age Signals receipt/discard and synchronize all eight privacy languages as version 2, 2026-10-07. No persistence/logging/advertising/UMP forwarding; no age payload crosses into Dart. This is implementation disclosure, not blanket state-law compliance.
- [ ] Verify receipt and Google's sharing UI on a Play-distributed build, startup/resume on a device, and applicable state-law obligations. Local unit tests/builds do not prove Play reception or satisfy Families age-screening requirements.
- [ ] Finalize processing legal bases, child/guardian notices, international-transfer disclosures and regional rights based on actual release operations. Do not copy Nova's personalized advertising, birth-date split, billing, or cloud-save wording.
- [ ] Verify and operationalize support handling, retention and rights-request procedures. Publishing this email rights-request channel may change the optional Console deletion-request answer; review that answer against the channel actually provided.
- [x] Add translations for zh-Hant, es, de, fr, pt-BR, ko; keep Portuguese support even though Brazil is excluded from distribution. Web documents cover all eight languages; app localization is still a separate task.
- [x] Add app legal links (App #262): Japanese anchors open in an external browser. These links and web files do not implement consent or a child-consent flow.
- [ ] Resolve and implement any required disclosure/consent flow separately.
- [ ] Before app release, update the version/date when behaviors change and align Console disclosures. Do not substitute publication of these current-behavior pages for the unresolved checks above.
- [ ] Verify deployed URLs return the intended publicly accessible HTML before registering them in Console.

## Primary references checked on 2026-10-04

- Google Play User Data: https://support.google.com/googleplay/android-developer/answer/10144311
- Mobile Ads data disclosure: https://developers.google.com/admob/android/privacy/play-data-disclosure
- Flutter advertising safeguards: https://developers.google.com/admob/flutter/targeting
- COPPA FAQ: https://www.ftc.gov/business-guidance/resources/complying-coppa-frequently-asked-questions
- Android Auto Backup: https://developer.android.com/identity/data/autobackup

No predecessor pages, homepage, deployment settings, app source, or Console declarations are changed by creating this directory. There is no Cruxevo-specific paid-product commercial disclosure or account-deletion portal because those products/accounts do not exist.
