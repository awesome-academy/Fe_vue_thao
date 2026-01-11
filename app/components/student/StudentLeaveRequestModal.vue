<template>
  <div
    v-if="modelValue && selectedClass"
    class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4"
    @click.self="$emit('update:modelValue', false)"
  >
    <div class="bg-white rounded-xl shadow-lg max-w-md w-full p-6 space-y-4">
      <h3 class="text-lg font-bold text-slate-800">
        {{ $t('student.classes.leave.title') }}
      </h3>
      <p class="text-sm text-slate-600">
        {{ $t('student.classes.leave.description') }}:
        <strong>{{ selectedClass.name }}</strong>
      </p>

      <div class="space-y-2">
        <label class="block text-sm font-medium text-slate-700">
          {{ $t('student.classes.leave.leaveType') }}
        </label>
        <div class="flex gap-3">
          <label class="flex items-center gap-2 cursor-pointer">
            <input
              v-model="leaveTypeLocal"
              type="radio"
              value="temporary"
              class="w-4 h-4"
            />
            <span class="text-sm text-slate-700">{{
              $t('student.classes.leave.temporary')
            }}</span>
          </label>
          <label class="flex items-center gap-2 cursor-pointer">
            <input
              v-model="leaveTypeLocal"
              type="radio"
              value="permanent"
              class="w-4 h-4"
            />
            <span class="text-sm text-slate-700">{{
              $t('student.classes.leave.permanent')
            }}</span>
          </label>
        </div>
      </div>

      <div v-if="leaveTypeLocal !== 'permanent'" class="space-y-2">
        <label class="block text-sm font-medium text-slate-700">
          {{ $t('student.classes.leave.date') }}
        </label>
        <input
          v-model="leaveDateLocal"
          type="date"
          class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-600 focus:border-transparent outline-none"
        />
      </div>

      <div class="space-y-2">
        <label class="block text-sm font-medium text-slate-700">
          {{ $t('student.classes.leave.reason') }}
        </label>
        <textarea
          v-model="leaveReasonLocal"
          class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-600 focus:border-transparent outline-none resize-none"
          rows="4"
          :placeholder="$t('student.classes.leave.reasonPlaceholder')"
        ></textarea>
      </div>

      <div class="flex gap-3">
        <button
          @click="$emit('update:modelValue', false)"
          class="flex-1 px-4 py-2 border border-slate-300 rounded-lg text-slate-700 font-medium hover:bg-slate-50 transition-colors"
        >
          {{ $t('student.classes.leave.cancel') }}
        </button>
        <button
          @click="submit"
          :disabled="
            (leaveTypeLocal === 'temporary' && !leaveDateLocal) ||
            !leaveReasonLocal.trim()
          "
          class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {{ $t('student.classes.leave.submit') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { StudentClass } from 'app/types/class';
import { ref } from 'vue';

const props = defineProps<{
  modelValue: boolean;
  selectedClass: StudentClass | null;
}>();

const emit = defineEmits<{
  'update:modelValue': [value: boolean];
  submit: [payload: { date: string; reason: string; leaveType: string }];
}>();

const leaveDateLocal = ref('');
const leaveReasonLocal = ref('');
const leaveTypeLocal = ref('temporary');

const submit = () => {
  if (
    ((leaveTypeLocal.value === 'temporary' && leaveDateLocal.value) ||
      leaveTypeLocal.value === 'permanent') &&
    leaveReasonLocal.value.trim()
  ) {
    emit('submit', {
      date: leaveDateLocal.value,
      reason: leaveReasonLocal.value,
      leaveType: leaveTypeLocal.value,
    });
    leaveDateLocal.value = '';
    leaveReasonLocal.value = '';
    leaveTypeLocal.value = 'temporary';
  }
};
</script>
