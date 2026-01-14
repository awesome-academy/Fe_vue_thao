<template>
  <div
    class="bg-white rounded-xl border border-slate-200 shadow-sm flex flex-col h-[600px] overflow-hidden"
  >
    <div class="grid grid-cols-7 border-b border-slate-200 bg-slate-50">
      <div
        v-for="(day, idx) in weekDays"
        :key="idx"
        class="py-3 text-center border-r border-slate-200 last:border-0"
      >
        <div class="text-xs font-bold text-slate-500 uppercase">
          {{ day }}
        </div>
        <div class="text-sm font-bold text-slate-800">{{ 7 + idx }}/01</div>
      </div>
    </div>
    <div class="flex-1 grid grid-cols-7 overflow-y-auto bg-white relative">
      <div class="absolute inset-0 grid grid-rows-6 pointer-events-none">
        <div
          v-for="n in 6"
          :key="n"
          class="border-b border-slate-50 h-full"
        ></div>
      </div>
      <div
        v-for="(dayEvents, dayIdx) in scheduleData"
        :key="dayIdx"
        class="border-r border-slate-100 last:border-0 p-1.5 relative min-h-[400px]"
      >
        <div
          v-for="(event, eIdx) in dayEvents"
          :key="eIdx"
          :class="[
            'p-2 rounded-lg border text-xs cursor-pointer shadow-sm hover:shadow-md transition-all mb-2',
            getEventColor(event.type),
          ]"
        >
          <div class="font-bold mb-0.5">{{ event.time }}</div>
          <div class="font-bold truncate text-sm mb-0.5">
            {{ event.subject }}
          </div>
          <div class="flex items-center gap-1 opacity-80">
            <i class="fa-solid fa-location-dot text-[10px]"></i>
            {{ event.room }}
          </div>
        </div>
        <div
          v-if="dayEvents.length === 0"
          class="h-full flex items-center justify-center opacity-20"
        >
          <i class="fa-solid fa-mug-hot text-2xl"></i>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
interface ScheduleEvent {
  time: string;
  subject: string;
  room: string;
  type: string;
}

defineProps<{
  scheduleData: ScheduleEvent[][];
}>();

const weekDays = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'];

const getEventColor = (type: string): string => {
  switch (type) {
    case 'blue':
      return 'bg-blue-50 border-blue-200 text-blue-700 hover:bg-blue-100';
    case 'green':
      return 'bg-emerald-50 border-emerald-200 text-emerald-700 hover:bg-emerald-100';
    case 'purple':
      return 'bg-purple-50 border-purple-200 text-purple-700 hover:bg-purple-100';
    default:
      return 'bg-slate-50 border-slate-200 text-slate-600';
  }
};
</script>
