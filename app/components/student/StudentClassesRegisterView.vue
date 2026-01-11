<template>
  <div
    class="bg-white rounded-xl border border-slate-200 shadow-sm flex flex-col h-full overflow-hidden"
  >
    <!-- Search & Filters -->
    <div class="p-6 border-b border-slate-100 bg-slate-50/50">
      <div class="relative max-w-xl">
        <input
          type="text"
          v-model="searchQueryLocal"
          :placeholder="$t('student.classes.searchPlaceholder')"
          class="w-full pl-10 pr-4 py-3 bg-white border border-slate-200 rounded-xl shadow-sm focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all"
        />
        <i
          class="fa-solid fa-magnifying-glass absolute left-3.5 top-3.5 text-slate-400"
        ></i>
      </div>
      <div class="flex gap-2 mt-3 overflow-x-auto pb-1">
        <button
          @click="subjectLocal = undefined"
          :class="[
            'px-3 py-1.5 text-xs font-bold rounded-lg shadow-sm transition-colors',
            !subjectLocal
              ? 'bg-blue-600 text-white'
              : 'bg-white border border-slate-200 text-slate-600 hover:text-blue-600 hover:border-blue-200',
          ]"
        >
          {{ $t('student.classes.filterAll') }}
        </button>
        <button
          v-for="subjectItem in subjects"
          :key="subjectItem"
          @click="subjectLocal = subjectItem"
          :class="[
            'px-3 py-1.5 text-xs font-bold rounded-lg transition-colors whitespace-nowrap',
            subjectLocal === subjectItem
              ? 'bg-blue-600 text-white shadow-sm'
              : 'bg-white border border-slate-200 text-slate-600 hover:text-blue-600 hover:border-blue-200',
          ]"
        >
          {{ subjectItem }}
        </button>
      </div>
    </div>

    <!-- Course Grid -->
    <CommonBaseLoading
      :active="pending"
      :text="$t('student.classes.loading')"
    />
    <div
      v-if="pending == false && error == null"
      class="flex-1 overflow-y-auto p-6 bg-slate-50 flex flex-col"
    >
      <div class="grid md:grid-cols-2 gap-4 flex-1">
        <div
          v-for="course in availableClasses"
          :key="course.id"
          class="bg-white p-5 rounded-xl border border-slate-200 shadow-sm hover:shadow-lg hover:border-blue-300 transition-all group relative"
        >
          <div
            class="absolute top-4 right-4 bg-blue-100 text-blue-700 text-[10px] font-bold px-2 py-1 rounded-full uppercase tracking-wide"
          >
            {{
              $t('student.classes.enrolledStudents', {
                count: course.student_count,
              })
            }}
          </div>
          <div class="flex items-start gap-4 mb-4">
            <div
              class="w-14 h-14 rounded-xl bg-gradient-to-br from-blue-500 to-indigo-600 text-white flex items-center justify-center font-bold text-xl shadow-md"
            >
              {{ course.name.charAt(0) }}
            </div>
            <div>
              <h4
                class="font-bold text-slate-800 text-lg leading-tight mb-1 group-hover:text-blue-600 transition-colors"
              >
                {{ course.name }}
              </h4>
              <div class="flex items-center gap-2 text-sm text-slate-500">
                <i class="fa-solid fa-chalkboard-user text-blue-400"></i>
                {{ course.teacher }}
              </div>
            </div>
          </div>

          <div
            class="bg-slate-50 rounded-lg p-3 mb-4 space-y-2 border border-slate-100"
          >
            <div class="flex justify-between text-sm">
              <span class="text-slate-500"
                ><i class="fa-regular fa-clock mr-1"></i>
                {{ $t('student.classes.schedule') }}:</span
              >
              <span class="font-bold text-slate-700">{{
                formatSchedule(course.schedule)
              }}</span>
            </div>
            <div class="flex justify-between text-sm">
              <span class="text-slate-500"
                ><i class="fa-solid fa-tag mr-1"></i>
                {{ $t('student.classes.tuition') }}:</span
              >
              <span class="font-bold text-blue-600"
                >{{ formatPrice(course.fee_per_session) }} /
                {{ $t('student.classes.month') }}</span
              >
            </div>
          </div>

          <div class="flex items-center justify-between gap-3">
            <div class="flex gap-1">
              <span
                class="text-[10px] font-bold bg-slate-100 text-slate-500 px-2 py-1 rounded border border-slate-200"
                >{{ course.grade_level }}</span
              >
              <span
                class="text-[10px] font-bold bg-blue-100 text-blue-600 px-2 py-1 rounded border border-blue-200"
                >{{ course.subject }}</span
              >
            </div>
            <button
              @click="$emit('register', course)"
              class="px-4 py-2 bg-blue-600 text-white text-sm font-bold rounded-lg hover:bg-blue-700 shadow-md hover:shadow-lg transition-all flex items-center gap-2"
            >
              {{ $t('student.classes.register') }}
              <i class="fa-solid fa-arrow-right"></i>
            </button>
          </div>
        </div>
      </div>

      <div
        v-if="availableClasses.length === 0"
        class="text-center py-10 text-slate-500"
      >
        <i class="fa-solid fa-magnifying-glass text-3xl mb-2 opacity-30"></i>
        <p>{{ $t('student.classes.noCoursesFound') }}</p>
      </div>

      <!-- Pagination for Available Classes -->
      <CommonPagination
        v-if="totalItems > 0"
        class="mt-4"
        :current-page="currentPage"
        :total-pages="totalPages"
        :items-per-page="itemsPerPage"
        :total-items="totalItems"
        @update:current-page="$emit('update:page', $event)"
        @update:items-per-page="$emit('update:per-page', $event)"
      />
    </div>
    <CommonBaseError
      v-if="error && !pending"
      :error="error"
      :title="$t('student.classes.errorTitle')"
      :onRetry="refresh"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import type { Class } from 'app/types/class';
const props = defineProps<{
  availableClasses: Class[];
  error: any;
  pending: boolean;
  refresh: () => void;
  subjects: string[];
  searchQuery: string;
  subject: string | undefined;
  page: number;
  perPage: number;
  totalPages: number;
  totalItems: number;
}>();

const emit = defineEmits<{
  'update:searchQuery': [value: string];
  'update:subject': [value: string | undefined];
  'update:page': [page: number];
  'update:per-page': [perPage: number];
  register: [course: Class];
}>();

const searchQueryLocal = ref(props.searchQuery);
const subjectLocal = ref(props.subject);
const currentPage = ref(props.page);
const itemsPerPage = ref(props.perPage);
const totalPages = ref(props.totalPages);
const totalItems = ref(props.totalItems);

watch(searchQueryLocal, (newVal) => {
  emit('update:searchQuery', newVal);
});

watch(subjectLocal, (newVal) => {
  emit('update:subject', newVal);
});

watch(
  () => props.searchQuery,
  (newVal) => {
    searchQueryLocal.value = newVal;
  }
);

watch(
  () => props.subject,
  (newVal) => {
    subjectLocal.value = newVal;
  }
);

watch(
  () => props.page,
  (newVal) => {
    currentPage.value = newVal;
  }
);

watch(
  () => props.perPage,
  (newVal) => {
    itemsPerPage.value = newVal;
  }
);

watch(
  () => props.totalPages,
  (newVal) => {
    totalPages.value = newVal;
  }
);

watch(
  () => props.totalItems,
  (newVal) => {
    totalItems.value = newVal;
  }
);

const formatSchedule = (schedule: any): string => {
  return formatScheduleObject(schedule) || '—';
};

const formatPrice = (price: string | number): string => {
  const numPrice = typeof price === 'string' ? parseFloat(price) : price;
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND',
  }).format(numPrice);
};
</script>
