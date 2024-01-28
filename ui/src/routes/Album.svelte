<script lang="ts">
	import Track from '$lib/Track.svelte';
	import { onMount } from 'svelte';
	import { listFiles } from '$lib/api/library';
	import { errorText } from '$lib/utils';

	let files: string[] = [];
	let error: string | null = null;
	let year = '2024';
	let label = 'Consectetur adipisicing elit';
	let cover_url = 'http://localhost:8000/cover.jpg';

	let selectedId = 0;

	onMount(async () => {
		try {
			files = await listFiles();
		} catch (e) {
			error = errorText(e);
		}
	});
</script>

<div class="flex h-full space-x-4">
	<div class="flex flex-col text-white items-start">
		<div class="w-96 h-96 cover-container">
			<img class="w-96 h-96 m-2 absolute blur-md" alt="album cover background" src={cover_url} />
			<a href="#/">
				<img
					class="cover-scale w-96 h-96 m-2 rounded-lg cover-scale hover:m-0 absolute transition-all"
					src={cover_url}
					alt="album cover"
				/>
			</a>
		</div>

		<div class="flex flex-col">
			<div class="font-bold text-gray-400 p-[2px] text-[10px]">ALBUM</div>
			<h1 class="mt-0 mb-3 font-bold text-2xl">Lorem Ipsum</h1>
			<div class="flex flex-row items-center space-x-2 my-1">
				<div class="w-6 h-6 bg-gray-400 rounded-full"></div>
				<a class="font-bold hover:underline" href="#/">Dolor sit amet</a>
			</div>
			<div class="my-1">
				<span class="text-gray-400">{year} &#x2022; {files.length} tracks &#x2022; {label}</span>
			</div>
			<div class="flex flex-wrap gap-x-1 gap-y-1 text-xs text-gray-400">
				<a href="#/" class="rounded-full bg-zinc-800 hover:bg-zinc-700 hover:text-white px-2 py-1"
					>#hyperpop</a
				>
				<a href="#/" class="rounded-full bg-zinc-800 hover:bg-zinc-700 hover:text-white px-2 py-1"
					>#electro-swing</a
				>
				<a href="#/" class="rounded-full bg-zinc-800 hover:bg-zinc-700 hover:text-white px-2 py-1"
					>#gangsta-rap</a
				>
				<a href="#/" class="rounded-full bg-zinc-800 hover:bg-zinc-700 hover:text-white px-2 py-1"
					>#mongolian-folk-rock</a
				>
				<a href="#/" class="rounded-full bg-zinc-800 hover:bg-zinc-700 hover:text-white px-2 py-1"
					>#anime-music</a
				>
			</div>
		</div>
	</div>

	<div class="flex flex-col text-white h-full overflow-scroll">
		{#each files as file, i}
			<Track
				id={file}
				name={file}
				artist={'Dolor sit amet'}
				index={i + 1}
				isSelected={i == selectedId}
			/>
		{:else}
			loading!
		{/each}

		{#if error}
			{error}
		{/if}
	</div>
</div>

<style>
	.cover-container,
	.cover-scale:hover {
		height: calc(theme(height.96) + 2 * theme(margin.2));
		width: calc(theme(height.96) + 2 * theme(margin.2));
	}
</style>
