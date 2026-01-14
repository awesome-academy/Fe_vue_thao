<template>
  <div
    class="flex flex-col sm:flex-row items-center justify-between gap-4 p-4 bg-white rounded-xl border border-slate-200 shadow-sm"
  >
    <!-- Left: Items Info -->
    <div class="text-sm text-slate-600">
      {{ $t('common.pagination.showing') }}
      <span class="font-bold text-slate-800">{{ startItem }}</span>
      {{ $t('common.pagination.to') }}
      <span class="font-bold text-slate-800">{{ endItem }}</span>
      {{ $t('common.pagination.of') }}
      <span class="font-bold text-slate-800">{{ totalItems }}</span>
      {{ $t('common.pagination.items') }}
    </div>

    <!-- Center: Page Numbers -->
    <div class="flex items-center gap-1">
      <!-- Previous Button -->
      <button
        @click="previousPage"
        :disabled="currentPage <= 1"
        class="px-3 py-2 rounded-lg text-sm font-bold transition-all flex items-center gap-1"
        :class="[
          currentPage <= 1
            ? 'bg-slate-100 text-slate-400 cursor-not-allowed'
            : 'bg-slate-100 text-slate-600 hover:bg-blue-100 hover:text-blue-600',
        ]"
      >
        <i class="fa-solid fa-chevron-left text-xs"></i>
        {{ $t('common.pagination.previous') }}
      </button>

      <!-- Page Numbers -->
      <div class="flex items-center gap-1">
        <!-- First Page -->
        <button
          v-if="startPage > 1"
          @click="goToPage(1)"
          class="px-3 py-2 rounded-lg text-sm font-bold transition-all bg-slate-100 text-slate-600 hover:bg-blue-100 hover:text-blue-600"
        >
          1
        </button>

        <!-- Ellipsis -->
        <span v-if="startPage > 2" class="px-2 py-2 text-slate-400">...</span>

        <!-- Page Range -->
        <button
          v-for="page in pageRange"
          :key="page"
          @click="goToPage(page)"
          :class="[
            'px-3 py-2 rounded-lg text-sm font-bold transition-all',
            page === currentPage
              ? 'bg-blue-600 text-white shadow-md'
              : 'bg-slate-100 text-slate-600 hover:bg-blue-100 hover:text-blue-600',
          ]"
        >
          {{ page }}
        </button>

        <!-- Ellipsis -->
        <span v-if="endPage < totalPages - 1" class="px-2 py-2 text-slate-400"
          >...</span
        >

        <!-- Last Page -->
        <button
          v-if="endPage < totalPages"
          @click="goToPage(totalPages)"
          class="px-3 py-2 rounded-lg text-sm font-bold transition-all bg-slate-100 text-slate-600 hover:bg-blue-100 hover:text-blue-600"
        >
          {{ totalPages }}
        </button>
      </div>

      <!-- Next Button -->
      <button
        @click="nextPage"
        :disabled="currentPage >= totalPages"
        class="px-3 py-2 rounded-lg text-sm font-bold transition-all flex items-center gap-1"
        :class="[
          currentPage >= totalPages
            ? 'bg-slate-100 text-slate-400 cursor-not-allowed'
            : 'bg-slate-100 text-slate-600 hover:bg-blue-100 hover:text-blue-600',
        ]"
      >
        {{ $t('common.pagination.next') }}
        <i class="fa-solid fa-chevron-right text-xs"></i>
      </button>
    </div>

    <!-- Right: Items Per Page -->
    <div class="flex items-center gap-3">
      <label class="text-sm text-slate-600 font-medium">
        {{ $t('common.pagination.itemsPerPage') }}:
      </label>
      <select
        :value="itemsPerPage"
        @change="updateItemsPerPage"
        class="px-3 py-2 border border-slate-200 rounded-lg text-sm font-bold text-slate-700 bg-white hover:border-blue-400 focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all cursor-pointer"
      >
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="30">30</option>
        <option value="50">50</option>
        <option value="100">100</option>
      </select>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';

interface Props {
  currentPage: number;
  totalPages: number;
  itemsPerPage: number;
  totalItems: number;
}

const props = defineProps<Props>();

const emit = defineEmits<{
  'update:currentPage': [page: number];
  'update:itemsPerPage': [limit: number];
}>();

const { t } = useI18n();

const visiblePages = 5; // Number of page buttons to show

const startPage = computed(() => {
  return Math.max(1, props.currentPage - Math.floor(visiblePages / 2));
});

const endPage = computed(() => {
  return Math.min(props.totalPages, startPage.value + visiblePages - 1);
});

const pageRange = computed(() => {
  const pages: number[] = [];
  for (let i = startPage.value; i <= endPage.value; i++) {
    pages.push(i);
  }
  return pages;
});

const startItem = computed(() => {
  return (props.currentPage - 1) * props.itemsPerPage + 1;
});

const endItem = computed(() => {
  return Math.min(props.currentPage * props.itemsPerPage, props.totalItems);
});

const previousPage = () => {
  if (props.currentPage > 1) {
    emit('update:currentPage', props.currentPage - 1);
  }
};

const nextPage = () => {
  if (props.currentPage < props.totalPages) {
    emit('update:currentPage', props.currentPage + 1);
  }
};

const goToPage = (page: number) => {
  if (page !== props.currentPage && page > 0 && page <= props.totalPages) {
    emit('update:currentPage', page);
  }
};

const updateItemsPerPage = (event: Event) => {
  const target = event.target as HTMLSelectElement;
  const newLimit = parseInt(target.value, 10);
  emit('update:itemsPerPage', newLimit);
};
</script>

<style scoped>
button:disabled {
  cursor: not-allowed;
}
</style>
