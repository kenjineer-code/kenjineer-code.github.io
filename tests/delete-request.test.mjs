import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

test('data deletion page identifies the Play listing and explains deletion retention', async () => {
  const page = await readFile(new URL('../delete-request.html', import.meta.url), 'utf8');

  assert.match(page, /ノヴァと空の宮殿：放置×編成ディフェンス/);
  assert.match(page, /Nova and the Sky Palace/);
  assert.match(page, /削除されるまで保持/);
  assert.match(page, /保存期間と削除方法は各事業者のポリシーに従います/);
  assert.match(page, /請求への対応完了後90日以内に削除/);
});
