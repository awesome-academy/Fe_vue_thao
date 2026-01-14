<template>
  <transition name="fade">
    <div
      v-if="error"
      class="flex flex-col items-center justify-center p-8 bg-red-50 border border-red-200 rounded-xl"
    >
      <!-- Error Icon -->
      <div
        class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mb-4"
      >
        <i class="fa-solid fa-circle-exclamation text-3xl text-red-600"></i>
      </div>

      <!-- Error Title -->
      <h3 class="text-lg font-bold text-red-900 mb-2">
        {{ title || 'Đã xảy ra lỗi' }}
      </h3>

      <!-- Error Message -->
      <p class="text-sm text-red-700 text-center mb-4 max-w-md">
        {{ message || 'Không thể tải dữ liệu. Vui lòng thử lại sau.' }}
      </p>

      <!-- Error Details (optional) -->
      <details v-if="showDetails && errorDetails" class="mb-4 w-full max-w-md">
        <summary
          class="text-xs text-red-600 cursor-pointer hover:text-red-800 font-medium"
        >
          Chi tiết lỗi
        </summary>
        <pre
          class="mt-2 p-3 bg-red-100 rounded text-xs text-red-800 overflow-auto max-h-40"
          >{{ errorDetails }}</pre
        >
      </details>

      <!-- Retry Button -->
      <button
        v-if="onRetry"
        @click="onRetry"
        class="px-6 py-2.5 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition-colors flex items-center gap-2"
      >
        <i class="fa-solid fa-rotate-right"></i>
        Thử lại
      </button>
    </div>
  </transition>
</template>

<script setup lang="ts">
interface Props {
  error: any;
  title?: string;
  message?: string;
  showDetails?: boolean;
  onRetry?: () => void;
}

const props = withDefaults(defineProps<Props>(), {
  showDetails: false,
});

const errorDetails = computed(() => {
  if (!props.error) return null;

  if (typeof props.error === 'string') return props.error;

  if (props.error?.data?.message) return props.error.data.message;
  if (props.error?.message) return props.error.message;
  if (props.error?.statusMessage) return props.error.statusMessage;

  return JSON.stringify(props.error, null, 2);
});
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
