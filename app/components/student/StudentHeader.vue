<template>
  <header
    class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-4 md:px-8 shadow-sm z-10"
  >
    <div>
      <h2 class="font-bold text-slate-800 text-lg flex items-center gap-2">
        {{ greeting
        }}<span class="animate-wave origin-bottom-right inline-block">👋</span>
      </h2>
      <p class="text-xs text-slate-500 hidden md:block">
        {{ t('student.header.subtitle') }}
      </p>
    </div>
    <div class="flex items-center gap-4">
      <!-- Notifications -->
      <button
        class="w-10 h-10 rounded-full bg-slate-50 flex items-center justify-center text-slate-500 hover:text-blue-600 hover:bg-blue-50 transition-colors relative"
      >
        <i class="fa-regular fa-bell"></i>
        <span
          class="absolute top-2 right-2.5 w-2 h-2 bg-red-500 rounded-full animate-pulse"
        ></span>
      </button>

      <!-- User Profile -->
      <div class="flex items-center gap-3 pl-4 border-l border-slate-200">
        <div class="text-right hidden md:block">
          <div class="text-sm font-bold text-slate-800">
            {{ authStore.user?.full_name }}
          </div>
          <div
            class="text-xs text-blue-600 font-semibold bg-blue-50 px-2 py-0.5 rounded-full inline-block"
          >
            {{ authStore.user?.email }}
          </div>
        </div>
        <img
          :src="authStore.user?.photo_url || '/default-avatar.png'"
          class="w-10 h-10 rounded-full border-2 border-blue-200 p-0.5"
        />
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
const { t } = useI18n();
const authStore = useAuthStore();
const greeting = computed(() => {
  const hour = new Date().getHours();
  if (hour < 12) {
    return `${t('student.header.goodMorning')}, ${authStore.user?.full_name}`;
  } else if (hour < 18) {
    return `${t('student.header.goodAfternoon')}, ${authStore.user?.full_name}`;
  } else {
    return `${t('student.header.goodEvening')}, ${authStore.user?.full_name}`;
  }
});
</script>

<style scoped>
@keyframes wave {
  0% {
    transform: rotate(0deg);
  }
  10% {
    transform: rotate(14deg);
  }
  20% {
    transform: rotate(-8deg);
  }
  30% {
    transform: rotate(14deg);
  }
  40% {
    transform: rotate(-4deg);
  }
  50% {
    transform: rotate(10deg);
  }
  60% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(0deg);
  }
}

.animate-wave {
  animation: wave 2s infinite;
  display: inline-block;
}
</style>
