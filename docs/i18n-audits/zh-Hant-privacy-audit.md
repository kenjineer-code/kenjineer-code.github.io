# 繁体字中国語（zh-Hant、台湾）プライバシーポリシー LLM監査記録

- 対象: `privacy.zh-Hant.html`（新規追加）。原文は `privacy.html` の英語セクション（v5、日本語セクションを参照）。
- ベースコミット（`privacy.zh-Hant.html`追加直前のHEAD）: `536a6c6`
- 実施日: 2026-11-03
- 経緯: アプリ（celestial_bastion）は Phase 1 から繁体字中国語に対応していたが、公開プライバシーポリシーの翻訳は Phase 2 の 5 言語（es・de・fr・ko・pt-BR）だけで、zh-Hant は作られていなかった。オーナー指示で追加。
- 繁体字ポリシー: 台湾の標準的な中国語（繁体字）。中国大陸の用語・表記は使わない（celestial_bastion `docs/i18n/glossary.md`）。アプリ内のボタン名はアプリの zh-TW 表記（`assets/l10n/app_zh_TW.arb`）に合わせる。
- 監査観点（共通）: (1) 原文対照（省略・追加・意味のずれ）、(2) 逆翻訳（英語へ戻した際の原意一致）、(3) 地域中立性（中国大陸・香港の用語、不自然な翻訳調の有無）、(4) 法的意味の一致（GDPR/CCPA/PIPA/LGPD の用語・データ種別・第三者・保存期間・同意撤回・削除・連絡先・国外移転・利用者の権利の強さと範囲）
- 意図的な差: 原文の "Privacy options"（設定画面の項目）は、出荷中の zh-TW アプリのボタン名「隱私權與廣告同意」（ARB `privacyOptions`）で訳した。利用者が画面上で同じ文字列を探せるようにするため。

## 1. Claude（翻訳担当・セルフレビュー）

- モデル: Claude Opus 5.5（Claude Code）
- 方法: 上記4観点で、Codex の結果を見る前にセルフレビュー。`jekyll build` と `bash scripts/check-privacy-locales.sh`（OK: all checks passed）を実行し、生成された `_site/privacy.zh-Hant.html` のフッター（隱私權政策 版本 5／最後更新日期：2026年10月23日）・言語スイッチャー・`?lang=zh-Hant` の転送先を確認。
- 指摘: なし。製品名は台湾の公式表記（Google Play 遊戲、Google Play 帳款服務、Apple 帳號）を使用。
- 判定: 自己判定で APPROVED 相当。

## 2. Codex（独立監査）

- モデル: OpenAI Codex（`codex exec --ignore-user-config -m gpt-6.1-sol --sandbox read-only`、ログで `model: gpt-6.1-sol` を確認）
- 実施日: 2026-11-03
- 方法: 4観点＋意図的な差（「隱私權與廣告同意」）とタイトル「隱私權政策 - 諾瓦與天空宮殿」の妥当性を、読み取り専用で確認。`VERDICT: APPROVED` または `VERDICT: REVISE` の一行出力を要求。
- 指摘: なし（4観点すべて "no findings"）。Google Play 帳款服務・Apple 帳號が公式表記と一致すること、「隱私權與廣告同意」は実際のボタンを示し権利と機能の説明を保っているため許容できることを確認。
- 判定: **VERDICT: APPROVED**

## 3. Gemini

- 未実施（このセッションから実行できる環境がない）。過去の言語ではオーナー経由で実施した。必要ならオーナーが同じ4観点で依頼し、結果をここに追記する。

## 最終判定

Claude・Codex の2系統で APPROVED。High/Critical の指摘や意味解釈の不一致は残っていない。

## 免責

本監査はLLMによるレビューであり、ネイティブスピーカーによるレビューや専門家による法務レビューの代替ではない。
