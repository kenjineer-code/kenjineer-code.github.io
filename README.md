# kenjineer-code.github.io
法的文書用（規約・プライバシーポリシー）

## ゲーム紹介ページ

`nova-and-the-sky-palace.html` は、2026年10月10日に配信を開始したAndroidゲームの静的な紹介ページ。スクロール演出・アニメーション・独自JavaScriptは使用しない。PVは公開版 `https://youtu.be/YwXzgvj_kXY` を手動再生する。トップページにはGoogle公式の日本語バッジ付きストアリンクと「Google Playで配信中」の案内を掲載。紹介ページの製品情報欄にもストアリンクを掲載する。プライバシーポリシーとデータ削除の案内は、紹介ページの製品情報欄から既存の `/privacy` と `/delete-request.html` にリンクする。

紹介文・製品情報・キービジュアル・宣伝文字なしのゲーム画面は、Google Driveの「ノヴァと空の宮殿｜報道用素材」を参照。`assets/nova/release/` にWebPとして保存し、Driveへの画像直リンクは使わない。仲間紹介の4点はオーナー提供の2026年9月30日のイラスト。公式YouTubeと公式Xはオーナー指定のURLを使用する。キャラクターの名前・年齢・セリフ・バックストーリーは、`celestial_bastion` の `CharacterStatusWindow` が参照する `assets/l10n/app_ja.arb` の `characterName/Age/Quote/Desc` を掲載する。

## privacy.html の多言語基盤

`privacy.html` は GitHub Pages 標準の Jekyll ビルドで多言語ルーティング（`?lang=<locale>` 選択・英語フォールバック・switcher）を提供する。設計判断の詳細は `kenjineer-code/celestial_bastion` リポジトリの `docs/adr/0018-privacy-html-jekyll-per-locale-routing.md` を参照。

- 公開/計画中のロケール一覧: `_data/locales.yml`
- バージョン・最終更新日（全ロケール共有）: `_data/legal_meta.yml`
- ローカル検証（依存ライブラリ不要、bash + jekyll のみ）:
  ```
  jekyll build
  bash scripts/check-privacy-locales.sh
  ```

Google Playバッジ：`assets/google-play-badge-ja.png`。Google公式配布元：`https://play.google.com/intl/en_us/badges/static/images/badges/ja_badge_web_generic.png`。加工せず縦横比を維持して使用する。
