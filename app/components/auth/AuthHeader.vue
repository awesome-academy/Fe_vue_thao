<template>
  <div class="text-center">
    <h2 class="text-3xl font-extrabold text-gray-900 tracking-tight">
      {{
        isLogin
          ? $t('auth.header.loginWelcome')
          : $t('auth.header.registerTitle')
      }}
    </h2>
    <p class="mt-2 text-sm text-gray-600">
      {{
        isLogin
          ? $t('auth.header.loginDescription')
          : $t('auth.header.registerDescription')
      }}
    </p>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  isLogin: boolean;
}>();
</script>
