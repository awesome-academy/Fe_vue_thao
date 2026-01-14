<template>
  <div class="grid md:grid-cols-2 gap-6 flex-1">
    <StudentClassCard
      v-for="cls in classes"
      :key="cls.id"
      :class-code="cls.code"
      :class-name="cls.name"
      :teacher="cls.teacher"
      :schedule="cls.schedule"
      :room="cls.room"
      :attended="cls.attended"
      :status="cls.status"
      :total-sessions="cls.totalSessions"
      @request-leave="$emit('request-leave', cls)"
      @makeup-class="$emit('makeup-class', cls)"
    />

    <!-- Add New Class Card (TRIGGER) -->
    <div
      @click="$emit('add-new')"
      class="bg-slate-50 rounded-xl border-2 border-dashed border-slate-300 flex flex-col items-center justify-center p-8 text-center hover:bg-blue-50 hover:border-blue-400 transition-all cursor-pointer group h-full min-h-[250px]"
    >
      <div
        class="w-16 h-16 bg-white rounded-full shadow-sm flex items-center justify-center mb-4 group-hover:scale-110 transition-transform text-blue-500 group-hover:text-blue-600 group-hover:shadow-md"
      >
        <i class="fa-solid fa-plus text-2xl"></i>
      </div>
      <h3
        class="font-bold text-slate-700 text-lg mb-1 group-hover:text-blue-700"
      >
        {{ $t('student.classes.addNew') }}
      </h3>
      <p class="text-sm text-slate-500">
        {{ $t('student.classes.findMore') }}
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { StudentClass } from 'app/types/class';

const props = defineProps<{
  classes: StudentClass[];
}>();
defineEmits<{
  'request-leave': [cls: StudentClass];
  'makeup-class': [cls: StudentClass];
  'add-new': [];
}>();
</script>
