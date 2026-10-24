import express from "express";

const app = express();

app.get("/api/health", (_request, response) => {
  response.json({ status: "ok", timestamp: new Date().toISOString() });
});

export const server = app.listen(process.env.PORT ?? 3001, "127.0.0.1", () => {
  console.log(`API disponível em http://127.0.0.1:${server.address().port}`);
});
