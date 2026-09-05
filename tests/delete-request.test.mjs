import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

test('data deletion page identifies the Play listing and explains deletion retention', async () => {
  const page = await readFile(new URL('../delete-request.html', import.meta.url), 'utf8');

  assert.match(page, /ノヴァと空の宮殿：放置×編成ディフェンス/);
  assert.match(page, /Nova and the Sky Palace/);
  assert.match(page, /「全データを削除」を実行するまで残ります/);
  assert.match(page, /保存期間と削除方法は、各社のポリシーに従います/);
  assert.match(page, /対応完了後90日以内に削除/);
});
