<template>
  <div>
    <button
      type="submit"
      class="group relative w-full flex justify-center py-2.5 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-primary hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-all duration-200 shadow-md hover:shadow-lg"
    >
      <span class="absolute left-0 inset-y-0 flex items-center pl-3">
        <i
          class="fas text-blue-300 group-hover:text-blue-200"
          :class="isLogin ? 'fa-sign-in-alt' : 'fa-user-plus'"
        ></i>
      </span>
      {{ isLogin ? $t('auth.buttons.login') : $t('auth.buttons.signup') }}
    </button>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  isLogin: boolean;
}>();
</script>
