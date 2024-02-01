import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		proxy: {
			"/api": {
				target: "http://localhost:1337",
				changeOrigin: true,
				secure: false,
				ws: true,
			},
		},
	},
});
