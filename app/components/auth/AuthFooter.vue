<template>
  <div class="border-t border-gray-200 pt-6 text-center">
    <p class="text-xs text-gray-400">
      &copy; {{ currentYear }} TMS Education. All rights reserved. <br />
      <a href="#" class="hover:text-gray-600">Điều khoản</a> &bull;
      <a href="#" class="hover:text-gray-600">Bảo mật</a>
    </p>
  </div>
</template>
<script setup>
const currentYear = new Date().getFullYear();
</script>
