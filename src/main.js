import "./style.css";

document.querySelector("#app").innerHTML = `
  <main>
    <p class="label">Projeto Integrador Extensionista II · Atividade 1</p>
    <h1>ONG</h1>
    <p>Uma base para conectar pessoas e transformar a comunidade.</p>
    <section aria-labelledby="connection-title">
      <h2 id="connection-title">Conexão com a API</h2>
      <p id="status" role="status">Consultando a API…</p>
      <p id="timestamp"></p>
      <code>GET /api/health</code>
    </section>
    <footer>Projeto acadêmico · Vite+ e Express</footer>
  </main>
`;

const status = document.querySelector("#status");

async function showHealth() {
  try {
    const response = await fetch("/api/health");
    if (!response.ok) throw new Error("A API não respondeu com sucesso.");

    const health = await response.json();
    const timestamp = new Date(health.timestamp);
    if (health.status !== "ok" || Number.isNaN(timestamp.getTime())) {
      throw new Error("Resposta da API inválida.");
    }

    status.textContent = `Status da API: ${health.status}`;
    document.querySelector("#timestamp").textContent =
      `Data e hora: ${timestamp.toLocaleString("pt-BR")}`;
  } catch {
    status.textContent = "Status da API: indisponível. Verifique se a API está em execução.";
  }
}

showHealth();
