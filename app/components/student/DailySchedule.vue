<template>
  <div
    class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-100"
  >
    <!-- Header -->
    <div
      class="p-5 border-b border-slate-100 flex items-center justify-between bg-gradient-to-r from-white to-blue-50"
    >
      <h3 class="font-bold text-slate-800 flex items-center gap-2">
        <div
          class="w-8 h-8 rounded-lg bg-blue-100 text-blue-600 flex items-center justify-center"
        >
          <i class="fa-solid fa-clock"></i>
        </div>
        {{ t('student.dailySchedule.title') }}
      </h3>
      <span
        class="text-xs font-bold bg-blue-100 text-blue-700 px-3 py-1.5 rounded-full border border-blue-200"
      >
        {{ today }}
      </span>
    </div>

    <!-- Classes List -->
    <div class="divide-y divide-slate-50">
      <div
        v-for="(cls, idx) in classes"
        :key="idx"
        class="p-5 hover:bg-blue-50/50 transition-colors group relative"
      >
        <!-- Status Indicator Line -->
        <div
          v-if="cls.status === 'live'"
          class="absolute left-0 top-0 bottom-0 w-1 bg-green-500"
        ></div>

        <div class="flex items-start gap-4 pl-2">
          <!-- Time Start Box -->
          <div
            class="flex flex-col items-center justify-center w-16 h-16 rounded-2xl transition-colors"
            :class="
              cls.status === 'live'
                ? 'bg-blue-600 text-white shadow-lg shadow-blue-500/30'
                : 'bg-slate-100 text-slate-500'
            "
          >
            <span class="text-[10px] font-bold uppercase opacity-80">{{
              t('student.dailySchedule.startTime')
            }}</span>
            <span class="text-lg font-bold">{{ cls.timeStart }}</span>
          </div>

          <!-- Class Info -->
          <div class="flex-1">
            <div class="flex items-center justify-between mb-1">
              <h4
                class="font-bold text-slate-800 text-lg group-hover:text-blue-600 transition-colors"
              >
                {{ cls.subject }}
              </h4>
              <span
                v-if="cls.status === 'live'"
                class="px-2 py-1 bg-green-100 text-green-700 text-xs font-bold rounded-md flex items-center gap-1 border border-green-200"
              >
                <span
                  class="w-2 h-2 bg-green-600 rounded-full animate-pulse"
                ></span>
                {{ t('student.dailySchedule.onGoing') }}
              </span>
              <span
                v-else
                class="px-2 py-1 bg-slate-100 text-slate-500 text-xs font-bold rounded-md border border-slate-200"
              >
                {{ t('student.dailySchedule.upcoming') }}
              </span>
            </div>

            <!-- Teacher & Room -->
            <div class="flex items-center gap-4 text-sm text-slate-500 mt-1">
              <span class="flex items-center gap-1.5">
                <i class="fa-solid fa-chalkboard-user text-blue-400"></i>
                {{ cls.teacher }}
              </span>
              <span class="flex items-center gap-1.5">
                <i class="fa-solid fa-location-dot text-blue-400"></i>
                {{ cls.room }}
              </span>
            </div>

            <!-- Action Buttons -->
            <div v-if="cls.status === 'live'" class="mt-3 flex gap-2">
              <button
                class="px-4 py-2 bg-blue-600 text-white text-sm font-bold rounded-lg hover:bg-blue-700 shadow-md hover:shadow-lg transition-all flex items-center gap-2"
              >
                <i class="fa-solid fa-video"></i>
                {{ t('student.dailySchedule.joinNow') }}
              </button>
              <button
                class="px-3 py-2 bg-white text-slate-600 border border-slate-200 rounded-lg hover:bg-slate-50 text-sm font-medium"
              >
                {{ t('student.dailySchedule.materials') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { DailyScheduleClass } from 'app/types/class';
interface StudentClass {
  timeStart: string;
  subject: string;
  teacher: string;
  room: string;
  status: 'dropped' | 'live' | 'upcoming';
}
const { t } = useI18n();

defineProps<{
  classes: StudentClass[];
}>();

const today = computed(() => {
  const now = new Date();
  const days = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
  const day = days[now.getDay()];
  const date = String(now.getDate()).padStart(2, '0');
  const month = String(now.getMonth() + 1).padStart(2, '0');
  return `${day}, ${date}/${month}`;
});
</script>
