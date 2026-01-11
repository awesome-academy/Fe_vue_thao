<template>
  <div
    class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-100"
  >
    <!-- Header -->
    <div
      class="p-5 border-b border-slate-100 flex items-center justify-between"
    >
      <h3 class="font-bold text-slate-800 flex items-center gap-2">
        <div
          class="w-8 h-8 rounded-lg bg-orange-100 text-orange-600 flex items-center justify-center"
        >
          <i class="fa-solid fa-list-check"></i>
        </div>
        {{ t('student.assignments.title') }}
      </h3>
      <NuxtLink
        to="/student/assignments"
        class="text-xs font-bold text-blue-600 bg-blue-50 px-3 py-1.5 rounded-lg hover:bg-blue-100 transition-colors"
      >
        {{ t('student.assignments.viewAll') }}
      </NuxtLink>
    </div>

    <!-- Tasks List -->
    <div class="p-4 grid gap-3">
      <div
        v-for="(task, idx) in assignments"
        :key="idx"
        class="flex items-center justify-between p-4 border rounded-xl transition-all cursor-pointer group"
        :class="
          task.isUrgent
            ? 'border-red-100 bg-red-50/30 hover:bg-red-50'
            : 'border-slate-100 bg-slate-50/50 hover:bg-white hover:shadow-md'
        "
      >
        <div class="flex items-center gap-4">
          <!-- Icon -->
          <div
            class="w-10 h-10 rounded-xl flex items-center justify-center transition-colors"
            :class="
              task.isUrgent
                ? 'bg-white text-red-500 border border-red-200'
                : 'bg-white text-blue-600 border border-blue-200'
            "
          >
            <i class="fa-solid fa-file-pen"></i>
          </div>

          <!-- Info -->
          <div>
            <h4
              class="font-bold text-slate-800 text-sm mb-0.5 group-hover:text-blue-600 transition-colors"
            >
              {{ task.title }}
            </h4>
            <div class="flex items-center gap-2 text-xs text-slate-500">
              <span
                class="bg-slate-200 px-1.5 py-0.5 rounded text-[10px] font-bold"
              >
                {{ task.class }}
              </span>
              <span>
                • {{ t('student.assignments.dueDate') }}:
                <span :class="{ 'text-red-600 font-bold': task.isUrgent }">
                  {{ task.dueDate }}
                </span>
              </span>
            </div>
          </div>
        </div>

        <!-- Urgent Indicator -->
        <div v-if="task.isUrgent" class="text-right">
          <span
            class="w-2 h-2 rounded-full bg-red-500 inline-block"
            title="Gấp"
          ></span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const { t } = useI18n();

defineProps<{
  assignments: Assignment[];
}>();
</script>
