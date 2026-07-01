# kenjineer-code.github.io
法的文書用（規約・プライバシーポリシー）

## privacy.html の多言語基盤

`privacy.html` は GitHub Pages 標準の Jekyll ビルドで多言語ルーティング（`?lang=<locale>` 選択・英語フォールバック・switcher）を提供する。設計判断の詳細は `kenjineer-code/celestial_bastion` リポジトリの `docs/adr/0018-privacy-html-jekyll-per-locale-routing.md` を参照。

- 公開/計画中のロケール一覧: `_data/locales.yml`
- バージョン・最終更新日（全ロケール共有）: `_data/legal_meta.yml`
- ローカル検証（依存ライブラリ不要、bash + jekyll のみ）:
  ```
  jekyll build
  bash scripts/check-privacy-locales.sh
  ```
