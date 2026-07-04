# ブラジルポルトガル語（pt-BR）プライバシーポリシー 3系統LLM監査記録

- 対象: `privacy.pt-BR.html`（新規追加）。原文は `privacy.html` の日本語・英語セクション（ADR-0019改修済み・Region-Specific Disclosures構造）。
- ベースコミット（`privacy.pt-BR.html`追加直前のHEAD）: `3798e23`（PR#13マージ後のmain）
- 実施日: 2026-07-04
- 関連Issue: kenjineer-code/kenjineer-code.github.io#6、親Issue celestial_bastion#390
- pt-BRポリシー: celestial_bastion `CONTEXT.md`（ブラジルのみを対象とするポルトガル語ローカライズ。`pt-PT`と地域指定のない`pt`には流用せず、対応言語が追加されるまでは英語へフォールバック）
- 監査観点（共通）: (1) 原文対照（省略・追加・意味のずれ）、(2) 逆翻訳（英語へ戻した際の原意一致）、(3) 地域正確性（欧州ポルトガル語混入の有無——語彙・"tu"系活用・正書法）、(4) 法的意味の一致（LGPD第18条の権利・GDPR/CCPA/PIPA用語・データ種別・第三者・保存期間・同意撤回・削除・連絡先・国外移転・利用者の権利の強さ・範囲）
- 新規翻訳のため、ADR-0019のRegion-Specific Disclosures構造（GDPR/CCPA/PIPA/LGPD/Provider-Controlled Dataの5自己完結段落）を最初から反映して作成。
- AC固有の検証: `?lang=pt` / `?lang=pt-PT` がプレビュー実機（jekyll serve）で英語(`privacy.html#lang-en`)へフォールバックし、`?lang=pt-BR`のみ`privacy.pt-BR.html`を選択することをこのセッションのブラウザプレビューで直接検証済み。`check-privacy-locales.sh`のチェック(d)でもpt/pt-PT/pt_BR/pt-br/PT-BR類似キーの不在を機械検証済み。

## 1. Claude（翻訳担当・セルフレビュー）

- モデル: Claude Sonnet 5（Claude Code）
- 実施日: 2026-07-04
- 方法: 上記4観点で、Codex/Geminiの結果を見る前に単独でセルフレビューを実施。加えてjekyll serveでの実表示確認（言語スイッチャー・フッター・LGPD段落を含む全文をブラウザプレビューで目視、`?lang=pt`/`?lang=pt-PT`/`?lang=pt-BR`のリダイレクト先を実機確認）。
- 指摘: なし。原文（en）対照・逆翻訳とも齟齬なし。LGPD段落はLGPD第18条の権利（confirmação da existência de tratamento=処理存在の確認、acesso=アクセス、correção=訂正、anonimização・bloqueio ou eliminação=匿名化・凍結・削除、portabilidade dos dados=データポータビリティ、informação sobre compartilhamento com terceiros=第三者提供情報、revogação do consentimento=同意撤回）を自己完結して記載。「você」による二人称直接対話の文体（他言語版と同一スタイル）を採用し、欧州ポルトガル語特有の"tu"活用・語彙・正書法の混入なし。
- 判定: 自己判定でAPPROVED相当。

## 2. Codex（独立監査）

- モデル: OpenAI Codex（`codex-cli 0.137.0`、`codex exec -s read-only --skip-git-repo-check`、既定モデル gpt-5.5）
- 実施日: 2026-07-04
- 実行コマンド: `codex exec -s read-only --skip-git-repo-check < <prompt>`（プロンプトは原文対照・逆翻訳・地域正確性(pt-BR vs pt-PT)・LGPD法的意味の4観点＋タイトル「Política de Privacidade - Nova e o Palácio Celestial」の妥当性確認。読み取り専用。`VERDICT: APPROVED`または`VERDICT: REVISE`の一行出力を要求）
- 指摘: なし（4観点すべて "no findings."）。
- 判定: **VERDICT: APPROVED**

## 3. Gemini（独立監査・オーナー経由リレー）

- モデル: Gemini（Google Antigravity経由、オーナー環境設定のモデルバージョン）
- 実施日: 2026-07-04
- 方法: オーナーが同一4観点のレビュープロンプトをGemini(Antigravity)へ提示し、結果をこのセッションへ貼り付けて共有。
- 指摘: なし（4観点すべて「指摘なし」）。欧州ポルトガル語特有の語彙（Aplicação/ecrã/contacto等）や"tu"系活用の混入がないことを明示的に確認。LGPD第18条の法定用語の正確な使用、段落の自己完結性、タイトルの自然さもいずれも確認済みとコメント。
- 判定: **VERDICT: APPROVED**

## 最終判定

3系統（Claude・Codex・Gemini）すべてAPPROVED。High/Critical指摘および意味解釈の不一致は残存しない。

## 免責

本監査はLLM（Claude・Codex・Gemini）による独立レビューであり、ネイティブスピーカーによるレビューや専門家による法務レビューの代替ではない。
