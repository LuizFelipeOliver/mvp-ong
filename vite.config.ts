import { defineConfig, loadEnv } from "vite-plus";

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), "");

  return {
    server: {
      port: 5173,
      strictPort: true,
      proxy: {
        "/api": `http://127.0.0.1:${process.env.PORT ?? env.PORT ?? 3001}`,
      },
    },
  };
});
