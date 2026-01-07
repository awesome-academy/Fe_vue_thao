<template>
  <div class="min-h-screen flex flex-col">
    <header class="bg-slate-700 text-white py-4 shadow-md">
      <nav class="container-custom flex items-center">
        <h1 class="text-2xl font-bold">Education Class Manager</h1>
      </nav>
    </header>

    <main class="flex-1 container-custom py-8">
      <slot />
    </main>

    <footer
      class="bg-gray-200 text-center py-4 border-t border-gray-300 mt-auto"
    >
      <p class="text-sm text-gray-600">
        &copy; {{ currentYear }} Education Class Manager
      </p>
    </footer>
  </div>
</template>
<script setup lang="ts">
const currentYear = new Date().getFullYear();
</script>
