<script lang="ts">
	import Header from '$lib/Header.svelte';
	import HeaderButton from '$lib/HeaderButton.svelte';
	import Album from './Album.svelte';
</script>

<Header>
	<HeaderButton title="Home" href="#" active={false}></HeaderButton>
	<HeaderButton title="Collection" href="#" active={true}></HeaderButton>
	<HeaderButton title="Settings" href="#" active={false}></HeaderButton>
</Header>

<Album />
