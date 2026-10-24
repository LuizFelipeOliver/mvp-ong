import assert from 'node:assert/strict';
import { once } from 'node:events';
import { test } from 'node:test';

test('GET /api/health retorna ok e data/hora válidas', async () => {
  process.env.PORT = '0';
  const { server } = await import('./index.js');

  try {
    await once(server, 'listening');
    const response = await fetch(`http://127.0.0.1:${server.address().port}/api/health`);
    assert.equal(response.status, 200);
    const body = await response.json();
    assert.equal(body.status, 'ok');
    assert.equal(new Date(body.timestamp).toISOString(), body.timestamp);
  } finally {
    await new Promise((resolve, reject) => {
      server.close((error) => (error ? reject(error) : resolve()));
    });
  }
});
