<script lang="ts">
	export let title: string;
	export let href: string;
	export let active: boolean;
</script>

<a
	{href}
	class:bg-white={active}
	class:text-black={active}
	class:hover:text-black={!active}
	class:hover:bg-white={!active}
	class="px-3 flex h-7 items-center transition select-none rounded-full"
>
	<span class="font-bold">{title}</span>
</a>
