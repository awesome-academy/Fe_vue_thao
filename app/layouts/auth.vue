<template>
  <div>
    <!-- Language Switcher - Top Right (Fixed Position) -->
    <div class="fixed top-4 right-4 z-50 p-2">
      <CommonLanguageSwitcher />
    </div>

    <slot />
  </div>
</template>

<script setup lang="ts"></script>
