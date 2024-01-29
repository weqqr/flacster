<script lang="ts">
	import Header from '$lib/Header.svelte';
	import HeaderButton from '$lib/HeaderButton.svelte';
	import Album from './Album.svelte';
</script>

<div class="m-auto max-w-screen-lg">
<Header>
	<HeaderButton title="Home" href="#" active={false}></HeaderButton>
	<HeaderButton title="Collection" href="#" active={true}></HeaderButton>
	<HeaderButton title="Settings" href="#" active={false}></HeaderButton>
</Header>
</div>

<main class="main h-full select-none max-w-screen-lg m-auto pt-4">
	<Album />
</main>

<style>
	.main {
		height: calc(100% - theme(height.8));
	}
</style>
