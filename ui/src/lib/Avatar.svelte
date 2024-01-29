<script lang="ts">
	export let src: string | null;
</script>

<div class="w-6 h-6 bg-gray-400 rounded-full">
	{#if src}
		<img {src} class="rounded-full" alt="avatar" />
	{/if}
</div>
