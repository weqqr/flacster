<script lang="ts">
	export let id: string;
	export let index: number;
	export let artist: string;
	export let name: string;
	export let isSelected: boolean;
	export let playing: boolean;
</script>

<div
	class:border-white={isSelected}
	class:hover:border-white={!isSelected}
	class:border-transparent={!isSelected}
	class="p-1 flex flex-row"
>
	<div class="flex flex-1 flex-row items-center space-x-3">
		<p class="min-w-4 text-gray-400 text-sm text-right">{index}</p>
		<div class:bg-white={playing} class="w-7 h-7 rounded-full flex items-center">
			{#if playing}
				<svg class="w-3 h-3 m-auto" viewBox="-1 0 8 8">
					<path
						fill-rule="evenodd"
						d="M1 0a1 1 0 0 0-1 1v6a1 1 0 0 0 2 0V1a1 1 0 0 0-1-1m5 1v6a1 1 0 0 1-2 0V1a1 1 0 0 1 2 0"
					/>
				</svg>
			{:else}
				<svg class="w-3 h-3 m-auto fill-white" viewBox="-0.5 0 7 7">
					<path
						fill-rule="evenodd"
						d="M5.495 2.573 1.5.143C.832-.266 0 .25 0 1.068V5.93c0 .82.832 1.333 1.5.927l3.995-2.43c.673-.41.673-1.445 0-1.855"
					/>
				</svg>
			{/if}
		</div>
		<div class="flex flex-col space-y-0">
			<p>{name}</p>
		</div>
	</div>
	<div class="flex items-center space-x-3 text-gray-400">3:14</div>
</div>
