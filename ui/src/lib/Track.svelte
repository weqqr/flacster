<script lang="ts">
	export let id: string;
	export let index: number;
	export let artist: string;
	export let name: string;
	export let isSelected: boolean;
</script>

<div
	class:border-white={isSelected}
	class:hover:border-white={!isSelected}
	class:border-transparent={!isSelected}
	class="border-2 px-2 flex flex-row"
>
	<div class="flex flex-1 flex-row items-center space-x-3">
		<p class="min-w-4 text-gray-400 text-sm text-right">{index}</p>
		<div class="w-7 h-7 rounded-full bg-white flex items-center"></div>
		<div class="flex flex-col space-y-0">
			<p>{name}</p>
			<a href="#/" class="text-gray-400 text-sm">{artist}</a>
		</div>
	</div>
	<div class="flex items-center space-x-3">3:14</div>
</div>
