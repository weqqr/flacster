<script>
	import Avatar from './Avatar.svelte';
</script>

<header class="top-0 sticky text-white bg-black">
	<div class="flex px-2 h-12 items-stretch">
		<div class="flex-1 flex space-x-2 items-center">
			<div class="px-3 flex items-center">
				<span class="px-3 logo">hOt GaRbAgE</span>
			</div>
			<slot />
		</div>
		<div class="flex space-x-1 items-center">
			<Avatar src={null} />
		</div>
	</div>
</header>

<style>
	.logo {
		font-family: 'Comic Sans MS', Arial, sans-serif;
	}
</style>
