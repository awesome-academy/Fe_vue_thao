<template>
  <div class="h-screen overflow-hidden flex bg-blue-50">
    <!-- Sidebar -->
    <StudentSidebar />

    <!-- Main Content -->
    <main class="flex-1 flex flex-col h-full overflow-hidden relative">
      <!-- Header -->
      <StudentHeader />

      <!-- Dashboard Body -->
      <div class="flex-1 overflow-y-auto p-4 md:p-8 custom-scroll">
        <div class="max-w-7xl mx-auto space-y-8">
          <slot />
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts"></script>

<style scoped>
.custom-scroll {
  scrollbar-width: thin;
  scrollbar-color: #93c5fd #f1f1f1;
}

.custom-scroll::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

.custom-scroll::-webkit-scrollbar-track {
  background: #f1f1f1;
}

.custom-scroll::-webkit-scrollbar-thumb {
  background: #93c5fd;
  border-radius: 3px;
}

.custom-scroll::-webkit-scrollbar-thumb:hover {
  background: #3b82f6;
}
</style>
