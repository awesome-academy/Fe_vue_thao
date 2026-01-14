<template>
  <div class="w-full h-screen flex items-center justify-center bg-gray-50">
    <div class="text-center">
      <h1 class="text-4xl font-bold mb-4">Đang tải...</h1>
      <p class="text-gray-600">Đang kiểm tra trạng thái đăng nhập</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';

onMounted(() => {
  const authToken = useCookie('auth_token').value;
  if (authToken) {
    navigateTo('/student');
  } else {
    navigateTo('/auth');
  }
});
</script>
