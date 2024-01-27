<script lang="ts">
	export let title: string;
	export let href: string;
	export let active: boolean;
</script>

<a
	{href}
	class:bg-white={active}
	class:text-black={active}
	class:bg-black={!active}
	class:text-white={!active}
	class:hover:text-black={!active}
	class:hover:bg-white={!active}
	class="px-3 flex items-center transition select-none"
>
	<span class="font-bold">{title}</span>
</a>
