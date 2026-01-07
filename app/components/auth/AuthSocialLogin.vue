<template>
  <div>
    <!-- Divider -->
    <div class="relative">
      <div class="absolute inset-0 flex items-center">
        <div class="w-full border-t border-gray-300"></div>
      </div>
      <div class="relative flex justify-center text-sm">
        <span class="px-2 bg-white text-gray-500">
          {{ $t('auth.social') }}
        </span>
      </div>
    </div>

    <!-- Social Login -->
    <div class="grid grid-cols-1 gap-3 mt-6">
      <button
        type="button"
        @click="$emit('google-login')"
        class="w-full inline-flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
      >
        <img
          class="h-5 w-5 mr-2"
          src="https://www.svgrepo.com/show/475656/google-color.svg"
          alt="Google"
        />
        <span>Google</span>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
defineEmits<{
  'google-login': [];
}>();
</script>
