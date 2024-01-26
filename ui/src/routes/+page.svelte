<script lang="ts">
	import { onMount } from 'svelte';

	let files: string[] = [];

	onMount(async () => {
		const res = await fetch('http://localhost:1337/api/v1/list-files');
		files = (await res.json())['files'];
	});
</script>

<h1>Welcome to SvelteKit</h1>
<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>

<ul>
	{#each files as file}
		<li>{file}</li>
	{:else}
		<p>loading</p>
	{/each}
</ul>
