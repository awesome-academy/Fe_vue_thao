<template>
  <div>
    <NuxtRouteAnnouncer />
    <CommonBaseLoading :active="isLoading" :text="loadingText" />
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>

<script setup lang="ts">
import { useLoading } from './composables/useLoading';
import './assets/styles/global.css';

const { isLoading, loadingText } = useLoading();
</script>
