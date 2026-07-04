# 韓国語（ko）プライバシーポリシー 3系統LLM監査記録

- 対象: `privacy.ko.html`（新規追加）。原文は `privacy.html` の日本語・英語セクション（ADR-0019改修済み・Region-Specific Disclosures構造）。
- ベースコミット（`privacy.ko.html`追加直前のHEAD）: `06ce3a4`（PR#12マージ後のmain）
- 実施日: 2026-07-04
- 関連Issue: kenjineer-code/kenjineer-code.github.io#3、親Issue celestial_bastion#387
- 韓国語ポリシー: celestial_bastion `CONTEXT.md`（大韓民国向け単一国ローカライズ。標準語/표준어を用い、北朝鮮式表記/문화어・方言表現・地域固有の俗語は避ける）
- 監査観点（共通）: (1) 原文対照（省略・追加・意味のずれ）、(2) 逆翻訳（英語へ戻した際の原意一致）、(3) 地域中立性（北朝鮮式表記/문화어・번역투の有無）、(4) 法的意味の一致（PIPA用語・GDPR/CCPA/LGPD用語・データ種別・第三者・保存期間・同意撤回・削除・連絡先・国外移転・利用者の権利の強さ・範囲）
- 新規翻訳のため、ADR-0019のRegion-Specific Disclosures構造（GDPR/CCPA/PIPA/LGPD/Provider-Controlled Dataの5自己完結段落）を最初から反映して作成。

## 1. Claude（翻訳担当・セルフレビュー）

- モデル: Claude Sonnet 5（Claude Code）
- 実施日: 2026-07-04
- 方法: 上記4観点で、Codex/Geminiの結果を見る前に単独でセルフレビューを実施。加えてjekyll serveでの実表示確認（言語スイッチャー・フッター・PIPA段落を含む全文をブラウザプレビューで目視）。
- 指摘: なし。原文（en）対照・逆翻訳とも齟齬なし。PIPA段落は個人情報保護法上の権利（열람=閲覧・정정=訂正・삭제=削除・처리정지=処理停止、PIPA第4条の情報主体の権利に対応）を自己完結して記載し、国外移転（韓国国外・米国等）も明示。北朝鮮式表記（문화어）・方言・不自然な번역투の混入なし。GDPR/CCPA/LGPD各段落も原文の権利範囲・用語（"data controller"→"개인정보 관리자"、"Sale"/"Share"→"판매"/"공유"等）を維持。
- 判定: 自己判定でAPPROVED相当。

## 2. Codex（独立監査）

- モデル: OpenAI Codex（`codex-cli 0.137.0`、`codex exec -s read-only --skip-git-repo-check`、既定モデル gpt-5.5）
- 実施日: 2026-07-04
- 実行コマンド: `codex exec -s read-only --skip-git-repo-check < <prompt>`（プロンプトは原文対照・逆翻訳・地域中立性・PIPA法的意味の4観点＋タイトル「개인정보처리방침 - 노바와 하늘의 궁전」の妥当性確認。読み取り専用。`VERDICT: APPROVED`または`VERDICT: REVISE`の一行出力を要求）
- 指摘: なし（4観点すべて "no findings."）。
- 判定: **VERDICT: APPROVED**

## 3. Gemini（独立監査・オーナー経由リレー）

- モデル: Gemini（Google Antigravity経由、オーナー環境設定のモデルバージョン）
- 実施日: 2026-07-04
- 方法: オーナーが同一4観点のレビュープロンプトをGemini(Antigravity)へ提示し、結果をこのセッションへ貼り付けて共有。
- 指摘: なし（4観点すべて「指摘なし」）。PIPA上の情報主体の権利（열람/정정/삭제/처리정지）等の法定用語の正確な使用、国外移転開示の自己完結性、標準的な韓国の法律用語（표준어）準拠、タイトルの自然さをいずれも確認済みとコメント。
- 判定: **VERDICT: APPROVED**

## 最終判定

3系統（Claude・Codex・Gemini）すべてAPPROVED。High/Critical指摘および意味解釈の不一致は残存しない。

## 免責

本監査はLLM（Claude・Codex・Gemini）による独立レビューであり、ネイティブスピーカーによるレビューや専門家による法務レビューの代替ではない。
