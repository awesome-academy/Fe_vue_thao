<template>
  <div
    class="bg-white p-4 rounded-xl shadow-sm border border-slate-100 hover:shadow-lg hover:shadow-blue-500/10 hover:border-blue-200 transition-all transform hover:-translate-y-1 duration-300"
  >
    <div class="flex items-center gap-3 mb-3">
      <div
        :class="[
          'w-10 h-10 rounded-xl flex items-center justify-center text-lg shadow-sm',
          color,
        ]"
      >
        <i :class="['fa-solid', icon]"></i>
      </div>
      <span
        class="text-sm text-slate-500 font-bold uppercase tracking-wider text-[10px]"
      >
        {{ title }}
      </span>
    </div>
    <div>
      <h3 class="text-2xl font-extrabold text-slate-800 mb-1">{{ value }}</h3>
      <span class="text-xs text-slate-400 font-medium block">{{
        subtitle
      }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  icon: string;
  color: string;
  title: string;
  value: string;
  subtitle: string;
}>();
</script>
