<script lang="ts">
	import Header from '$lib/Header.svelte';
	import HeaderButton from '$lib/HeaderButton.svelte';
	import Album from './Album.svelte';
</script>

<style>
	.main {
		height: calc(100% - theme(height.8));
	}
</style>

<Header>
	<HeaderButton title="Home" href="#" active={false}></HeaderButton>
	<HeaderButton title="Collection" href="#" active={true}></HeaderButton>
	<HeaderButton title="Settings" href="#" active={false}></HeaderButton>
</Header>

<main class="main overflow-scroll select-none">
	<div class="max-w-screen-lg m-auto pt-4">
		<Album />
	</div>
</main>
