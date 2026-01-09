<template>
  <div class="text-center mt-4">
    <p class="text-sm text-gray-600">
      {{ isLogin ? $t('auth.toggle.noAccount') : $t('auth.toggle.hasAccount') }}
      <button
        @click="$emit('toggle')"
        class="font-medium text-primary hover:text-blue-600 transition-colors"
      >
        {{
          isLogin ? $t('auth.toggle.registerNow') : $t('auth.toggle.loginNow')
        }}
      </button>
    </p>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  isLogin: boolean;
}>();

defineEmits<{
  toggle: [];
}>();
</script>
