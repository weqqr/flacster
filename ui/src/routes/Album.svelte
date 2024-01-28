<script lang="ts">
	import Track from '$lib/Track.svelte';
	import { onMount } from 'svelte';
	import { listFiles } from '$lib/api/library';
	import { errorText } from '$lib/utils';

	let files: string[] = [];
	let error: string | null = null;
	let year = '2024';
	let label = 'Consectetur adipisicing elit';

	let selectedId = 0;

	onMount(async () => {
		try {
			files = await listFiles();
		} catch (e) {
			error = errorText(e);
		}
	});
</script>

<div class="flex text-white items-center">
	<div class="w-48 h-48 bg-gray-400 my-4 mr-8"></div>

	<div class="flex flex-col">
		<div class="font-bold text-gray-400 p-[2px] text-[10px]">ALBUM</div>
		<h1 class="mt-0 mb-3 font-bold text-6xl">Lorem Ipsum</h1>
		<div class="flex flex-row items-center space-x-2">
			<div class="w-6 h-6 bg-gray-400 rounded-full"></div>
			<a class="font-bold" href="#/">Dolor sit amet</a>
			<span class=" text-gray-400">{year} &#x2022; {files.length} tracks &#x2022; {label}</span>
		</div>
	</div>
</div>

<div class="flex-col text-white">
	{#each files as file, i}
		<Track id={file} name={file} artist={"Dolor sit amet"} index={i + 1} isSelected={i == selectedId} />
	{:else}
		loading!
	{/each}

	{#if error}
		{error}
	{/if}
</div>
