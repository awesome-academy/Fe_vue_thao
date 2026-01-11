<template>
  <div
    class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 bg-white p-4 rounded-xl shadow-sm border border-blue-100"
  >
    <div v-if="viewMode !== 'register'">
      <h2 class="text-2xl font-bold text-slate-800">
        {{ $t('student.classes.myClasses') }}
      </h2>
      <p class="text-sm text-slate-500">
        {{ $t('student.classes.description') }}
      </p>
    </div>
    <div v-else>
      <button
        @click="$emit('back')"
        class="text-slate-500 hover:text-blue-600 text-sm font-bold flex items-center gap-2 mb-1"
      >
        <i class="fa-solid fa-arrow-left"></i>
        {{ $t('student.classes.back') }}
      </button>
      <h2 class="text-2xl font-bold text-slate-800">
        {{ $t('student.classes.registerNew') }}
      </h2>
    </div>

    <div v-if="viewMode !== 'register'" class="flex gap-3">
      <button
        @click="$emit('switch-view', 'list')"
        :class="[
          'px-4 py-2 rounded-lg text-sm font-bold transition-all flex items-center gap-2',
          viewMode === 'list'
            ? 'bg-blue-600 text-white shadow-md'
            : 'bg-slate-100 text-slate-500 hover:text-slate-700',
        ]"
      >
        <i class="fa-solid fa-list"></i>
        {{ $t('student.classes.viewModes.list') }}
      </button>
      <button
        @click="$emit('switch-view', 'calendar')"
        :class="[
          'px-4 py-2 rounded-lg text-sm font-bold transition-all flex items-center gap-2',
          viewMode === 'calendar'
            ? 'bg-blue-600 text-white shadow-md'
            : 'bg-slate-100 text-slate-500 hover:text-slate-700',
        ]"
      >
        <i class="fa-solid fa-calendar-days"></i>
        {{ $t('student.classes.viewModes.calendar') }}
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  viewMode: 'list' | 'calendar' | 'register';
}>();

defineEmits<{
  'switch-view': [mode: 'list' | 'calendar' | 'register'];
  back: [];
}>();
</script>
