<script lang="ts">
	import Track from '$lib/Track.svelte';
	import { onMount } from 'svelte';
	import { listFiles } from '$lib/api/library';
	import { errorText } from '$lib/utils';

	let files: string[] = [];
	let error: string | null = null;

	onMount(async () => {
		try {
			files = await listFiles();
		} catch (e) {
			error = errorText(e);
		}
	});
</script>

<div class="text-white">
	{#each files as file}
		<Track id={file} />
	{:else}
		loading!
	{/each}

	{#if error}
		{error}
	{/if}
</div>
