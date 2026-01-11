<template>
  <div
    class="bg-white rounded-xl border border-slate-200 shadow-sm hover:shadow-md hover:border-blue-200 transition-all overflow-hidden group"
  >
    <!-- Class Header -->
    <div
      class="p-5 border-b border-slate-100 bg-gradient-to-r from-white to-blue-50/50 flex justify-between items-start"
    >
      <div class="flex gap-4">
        <div
          class="w-12 h-12 rounded-lg bg-blue-100 text-blue-600 flex items-center justify-center font-bold text-xl"
        >
          {{ classCode }}
        </div>
        <div>
          <h3
            class="font-bold text-slate-800 text-lg group-hover:text-blue-600 transition-colors"
          >
            {{ className }}
          </h3>
          <p class="text-sm text-slate-500">
            <i class="fa-solid fa-user-tie mr-1 text-blue-400"></i>
            {{ teacher }}
          </p>
        </div>
      </div>
      <span
        :class="{
          'bg-green-100 text-green-700': status === 'active',
          'bg-yellow-100 text-yellow-700': status === 'pending',
          'bg-red-100 text-red-700': status === 'dropped',
        }"
        class="text-xs font-bold px-2 py-1 rounded-full"
      >
        {{ $t(`student.classes.status.${status}`) }}
      </span>
    </div>

    <!-- Class Body -->
    <div class="p-5 space-y-4">
      <!-- Progress -->
      <div>
        <div class="flex justify-between text-xs font-medium mb-1.5">
          <span class="text-slate-500">{{
            $t('student.classes.progress')
          }}</span>
          <span class="text-blue-600"
            >{{ attended }}/{{ totalSessions }}
            {{ $t('student.classes.sessions') }}</span
          >
        </div>
        <div class="w-full bg-slate-100 rounded-full h-2">
          <div
            class="bg-blue-600 h-2 rounded-full transition-all"
            :style="{ width: (attended / totalSessions) * 100 + '%' }"
          ></div>
        </div>
      </div>

      <!-- Schedule Info -->
      <div
        class="flex gap-3 text-sm bg-slate-50 p-3 rounded-lg border border-slate-100"
      >
        <div class="flex-1">
          <div class="text-xs text-slate-400 font-bold uppercase mb-1">
            {{ $t('student.classes.schedule') }}
          </div>
          <div class="font-medium text-slate-700">{{ schedule }}</div>
        </div>
        <div class="flex-1 border-l border-slate-200 pl-3">
          <div class="text-xs text-slate-400 font-bold uppercase mb-1">
            {{ $t('student.classes.room') }}
          </div>
          <div class="font-medium text-slate-700">{{ room }}</div>
        </div>
      </div>

      <!-- Actions Buttons -->
      <div class="grid grid-cols-2 gap-3 pt-2">
        <button
          v-if="status !== 'dropped'"
          @click="$emit('request-leave')"
          :class="{
            'col-span-2': status === 'pending',
          }"
          class="px-3 py-2 bg-white border border-slate-200 text-slate-600 rounded-lg text-sm font-bold hover:bg-slate-50 hover:text-red-500 hover:border-red-200 transition-colors flex items-center justify-center gap-2"
        >
          <i class="fa-solid fa-person-walking-arrow-right"></i>
          {{
            $t(
              `student.classes.actions.${
                status === 'pending' ? 'cancel' : 'leave'
              }`
            )
          }}
        </button>
        <button
          v-if="status === 'active'"
          @click="$emit('join-class')"
          class="px-3 py-2 bg-blue-500 text-white rounded-lg text-sm font-bold hover:bg-blue-600 transition-colors flex items-center justify-center gap-2"
        >
          <i class="fa-solid fa-door-open"></i>
          {{ $t('student.classes.actions.join') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  classCode: string;
  className: string;
  teacher: string;
  schedule: string;
  room: string;
  attended: number;
  totalSessions: number;
  status: 'dropped' | 'pending' | 'active';
}>();

defineEmits<{
  'request-leave': [];
  'join-class': [];
}>();
</script>
