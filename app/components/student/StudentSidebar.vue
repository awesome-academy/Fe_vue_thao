<template>
  <aside
    class="w-20 lg:w-64 bg-blue-600 text-white flex-shrink-0 flex flex-col transition-all duration-300 shadow-xl z-20"
  >
    <!-- Logo -->
    <div
      class="h-16 flex items-center justify-center lg:justify-start lg:px-6 border-b border-white/20"
    >
      <div
        class="w-9 h-9 bg-white rounded-xl flex items-center justify-center text-blue-600 font-extrabold text-xl shadow-lg"
      >
        T
      </div>
      <span
        class="ml-3 font-bold text-xl text-white hidden lg:block tracking-tight"
      >
        TMS Student
      </span>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 py-6 px-3 space-y-2">
      <!-- Dashboard -->
      <NuxtLink
        to="/student"
        :class="[
          'flex items-center gap-3 px-3 py-3 rounded-xl font-medium transition-all',
          isActive('/student')
            ? 'bg-white/20 text-white shadow-inner border border-white/10 backdrop-blur-sm font-bold'
            : 'text-blue-100 hover:bg-white/10 hover:text-white group',
        ]"
      >
        <i class="fa-solid fa-house w-6 text-center"></i>
        <span class="hidden lg:block">{{ t('student.menu.dashboard') }}</span>
      </NuxtLink>

      <!-- Schedule -->
      <NuxtLink
        to="/student/schedule"
        :class="[
          'flex items-center gap-3 px-3 py-3 rounded-xl font-medium transition-all',
          isActive('/student/schedule')
            ? 'bg-white/20 text-white shadow-inner border border-white/10 backdrop-blur-sm font-bold'
            : 'text-blue-100 hover:bg-white/10 hover:text-white group',
        ]"
      >
        <i
          class="fa-solid fa-calendar-days w-6 text-center group-hover:scale-110 transition-transform"
        ></i>
        <span class="hidden lg:block">{{ t('student.menu.schedule') }}</span>
      </NuxtLink>

      <!-- Classes -->
      <NuxtLink
        to="/student/classes"
        :class="[
          'flex items-center gap-3 px-3 py-3 rounded-xl font-medium transition-all',
          isActive('/student/classes')
            ? 'bg-white/20 text-white shadow-inner border border-white/10 backdrop-blur-sm font-bold'
            : 'text-blue-100 hover:bg-white/10 hover:text-white group',
        ]"
      >
        <i
          class="fa-solid fa-chalkboard-user w-6 text-center group-hover:scale-110 transition-transform"
        ></i>
        <span class="hidden lg:block">{{
          t('student.menu.classes', 'Classes')
        }}</span>
      </NuxtLink>

      <!-- Assignments -->
      <NuxtLink
        to="/student/assignments"
        :class="[
          'flex items-center gap-3 px-3 py-3 rounded-xl font-medium transition-all',
          isActive('/student/assignments')
            ? 'bg-white/20 text-white shadow-inner border border-white/10 backdrop-blur-sm font-bold'
            : 'text-blue-100 hover:bg-white/10 hover:text-white group',
        ]"
      >
        <div class="relative">
          <i
            class="fa-solid fa-book w-6 text-center group-hover:scale-110 transition-transform"
          ></i>
          <span
            class="absolute -top-1 -right-1 w-2.5 h-2.5 bg-red-500 rounded-full border-2 border-blue-600"
          ></span>
        </div>
        <span class="hidden lg:block">{{ t('student.menu.assignments') }}</span>
      </NuxtLink>

      <!-- Results -->
      <NuxtLink
        to="/student/results"
        :class="[
          'flex items-center gap-3 px-3 py-3 rounded-xl font-medium transition-all',
          isActive('/student/results')
            ? 'bg-white/20 text-white shadow-inner border border-white/10 backdrop-blur-sm font-bold'
            : 'text-blue-100 hover:bg-white/10 hover:text-white group',
        ]"
      >
        <i
          class="fa-solid fa-chart-pie w-6 text-center group-hover:scale-110 transition-transform"
        ></i>
        <span class="hidden lg:block">{{ t('student.menu.results') }}</span>
      </NuxtLink>

      <!-- Tuition -->
      <NuxtLink
        to="/student/tuition"
        :class="[
          'flex items-center gap-3 px-3 py-3 rounded-xl font-medium transition-all',
          isActive('/student/tuition')
            ? 'bg-white/20 text-white shadow-inner border border-white/10 backdrop-blur-sm font-bold'
            : 'text-blue-100 hover:bg-white/10 hover:text-white group',
        ]"
      >
        <i
          class="fa-solid fa-wallet w-6 text-center group-hover:scale-110 transition-transform"
        ></i>
        <span class="hidden lg:block">{{ t('student.menu.tuition') }}</span>
      </NuxtLink>
    </nav>

    <!-- Logout -->
    <div class="p-4 border-t border-white/20 bg-black/10">
      <button
        @click="handleLogout"
        class="flex items-center gap-3 text-blue-100 hover:text-white transition-colors w-full justify-center lg:justify-start px-2 group"
      >
        <i
          class="fa-solid fa-arrow-right-from-bracket w-6 text-center group-hover:-translate-x-1 transition-transform"
        ></i>
        <span class="hidden lg:block font-medium text-sm">{{
          t('common.logout')
        }}</span>
      </button>
    </div>
  </aside>
</template>

<script setup lang="ts">
import { useToast } from 'vue-toastification';

const { t } = useI18n();
const authStore = useAuthStore();
const toast = useToast();
const route = useRoute();

const isActive = (path: string) => {
  if (path === '/student') {
    return route.path === '/student';
  }
  return route.path.startsWith(path);
};

const handleLogout = () => {
  try {
    authStore.logout();
    toast.success(t('common.logoutSuccess'));
    navigateTo('/auth');
  } catch (error) {
    console.error('Logout failed:', error);
    toast.error(t('common.logoutError'));
  }
};
</script>
