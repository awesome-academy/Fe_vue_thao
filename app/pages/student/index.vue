<template>
  <div class="space-y-8">
    <!-- Stats Overview -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
      <StudentStatCard
        v-for="stat in stats"
        :key="stat.title"
        :icon="stat.icon"
        :color="stat.color"
        :title="stat.title"
        :value="stat.value"
        :subtitle="stat.subtitle"
      />
    </div>

    <!-- Main Content Grid -->
    <div class="grid lg:grid-cols-3 gap-8">
      <!-- Left Column (2/3) -->
      <div class="lg:col-span-2 space-y-8">
        <!-- Daily Schedule -->
        <StudentDailySchedule :classes="todayClasses" />

        <!-- Assignment List -->
        <StudentAssignmentList :assignments="pendingAssignments" />
      </div>

      <!-- Right Column (1/3) -->
      <div class="space-y-8">
        <!-- Tuition Alert -->
        <StudentTuitionAlert :tuition="tuitionData" />

        <!-- Teacher Feedback -->
        <div class="bg-white rounded-xl shadow-sm p-6 border border-blue-100">
          <div class="flex items-center justify-between mb-4">
            <h3 class="font-bold text-slate-800 flex items-center gap-2">
              <i class="fa-regular fa-comment-dots text-blue-600"></i>
              {{ t('student.feedback.title') }}
            </h3>
            <button class="text-xs text-blue-600 font-semibold hover:underline">
              {{ t('student.feedback.viewHistory') }}
            </button>
          </div>
          <div class="space-y-4">
            <div
              class="bg-blue-50 p-4 rounded-xl border border-blue-100 relative"
            >
              <i
                class="fa-solid fa-quote-right absolute top-2 right-3 text-blue-200 text-xl"
              ></i>
              <div class="flex items-center gap-3 mb-2">
                <div class="relative">
                  <img
                    src="https://ui-avatars.com/api/?name=Co+Hoa&background=2563EB&color=fff"
                    class="w-8 h-8 rounded-full border-2 border-white shadow-sm"
                  />
                  <div
                    class="absolute -bottom-1 -right-1 bg-green-500 w-3 h-3 rounded-full border-2 border-white"
                  ></div>
                </div>
                <div>
                  <div class="text-xs font-bold text-slate-800">
                    {{ t('student.feedback.teacher') }}
                  </div>
                  <div class="text-[10px] text-slate-500">
                    {{ t('student.feedback.timeAgo') }}
                  </div>
                </div>
              </div>
              <p class="text-sm text-slate-600 leading-relaxed">
                {{ t('student.feedback.message') }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: 'student',
  middleware: 'auth',
});

const { t } = useI18n();
const { todayClasses, pendingAssignments, tuitionData, stats } = useDashboard();
</script>
