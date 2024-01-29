<script lang="ts">
	import Track from '$lib/Track.svelte';
	import { onMount } from 'svelte';
	import { listFiles } from '$lib/api/library';
	import { errorText } from '$lib/utils';
	import Tag from '$lib/Tag.svelte';
	import Avatar from '$lib/Avatar.svelte';

	let files: string[] = [];
	let error: string | null = null;
	let year = '2024';
	let label = 'Consectetur adipisicing elit';
	let cover_url = 'http://localhost:8000/cover.jpg';
	let tags = ['lorem ipsum'];

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
			<!-- <img class="w-96 h-96 m-2 absolute blur-md" alt="album cover background" src={cover_url} /> -->
			<a href="#/">
				<img
					class="cover-scale w-96 h-96 m-2 rounded-lg cover-scale hover:m-0 absolute transition-all"
					src={cover_url}
					alt="album cover"
				/>
			</a>
		</div>

		<div class="flex flex-col space-y-2">
			<div>
				<div class="font-bold text-gray-400 p-[2px] text-[10px]">ALBUM</div>
				<h1 class="font-bold text-2xl">Lorem Ipsum</h1>
			</div>

			<div class="flex flex-row items-center space-x-2">
				<Avatar src={cover_url} />
				<a class="font-bold hover:underline" href="#/">Dolor sit amet</a>
			</div>

			<div class="">
				<span class="text-gray-400">{year} &#x2022; {files.length} tracks &#x2022; {label}</span>
			</div>

			<div class="flex flex-wrap gap-x-1 gap-y-1 text-xs text-gray-400">
				{#each tags as tag}
					<Tag text={tag} href="#/" />
				{/each}
			</div>
		</div>
	</div>

	<div class="flex flex-1 flex-col text-white h-full overflow-scroll">
		{#each files as file, i}
			<Track
				id={file}
				name={'Track ' + (i+1)}
				artist={'Dolor sit amet'}
				index={i + 1}
				isSelected={i == selectedId}
				playing={i == 2}
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
