<template>
  <div v-if="isLogin" class="flex items-center justify-between">
    <!-- <div class="flex items-center">
      <input
        id="remember-me"
        name="remember-me"
        type="checkbox"
        class="h-4 w-4 text-primary focus:ring-primary border-gray-300 rounded"
      />
      <label for="remember-me" class="ml-2 block text-sm text-gray-900">
        {{ $t('auth.rememberMe') }}
      </label>
    </div> -->

    <div class="text-sm">
      <NuxtLink
        to="/auth/forgot-password"
        class="font-medium text-primary hover:text-blue-600 transition-colors"
      >
        {{ $t('common.forgotPassword') }}
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  isLogin: boolean;
}>();
</script>
