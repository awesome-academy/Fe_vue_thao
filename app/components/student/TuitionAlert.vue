<template>
  <div
    class="bg-gradient-to-br from-blue-600 to-indigo-700 rounded-2xl shadow-xl shadow-blue-500/20 text-white p-6 relative overflow-hidden group"
  >
    <!-- Background Decoration -->
    <div
      class="absolute top-0 right-0 -mr-8 -mt-8 w-32 h-32 bg-white/10 rounded-full blur-3xl group-hover:bg-white/20 transition-all duration-700"
    ></div>
    <div
      class="absolute bottom-0 left-0 -ml-8 -mb-8 w-24 h-24 bg-indigo-500/30 rounded-full blur-2xl"
    ></div>

    <div class="relative z-10">
      <!-- Header -->
      <div class="flex items-start justify-between mb-4">
        <div class="flex items-center gap-2">
          <div
            class="w-8 h-8 rounded-full bg-white/20 flex items-center justify-center backdrop-blur-sm"
          >
            <i class="fa-solid fa-bell text-yellow-300"></i>
          </div>
          <h3 class="font-bold text-lg">{{ t('student.tuition.title') }}</h3>
        </div>
        <span
          class="bg-red-500 text-white text-[10px] font-bold px-2 py-1 rounded shadow-sm"
        >
          {{ t('student.tuition.important') }}
        </span>
      </div>

      <!-- Message -->
      <p
        class="text-blue-50 text-sm mb-5 leading-relaxed bg-white/10 p-3 rounded-lg border border-white/10"
      >
        {{
          t('student.tuition.message', {
            package: tuition.package,
            expiryDate: tuition.expiryDate,
          })
        }}
      </p>

      <!-- Amount -->
      <div class="flex items-center justify-between mb-5">
        <span class="text-xs text-blue-100 font-medium">{{
          t('student.tuition.amountDue')
        }}</span>
        <span class="font-bold text-2xl tracking-tight">{{
          tuition.debt
        }}</span>
      </div>

      <!-- Payment Button -->
      <button
        class="w-full py-3 bg-white text-blue-700 font-bold rounded-xl text-sm hover:bg-blue-50 transition-all shadow-lg flex items-center justify-center gap-2 group-hover:scale-[1.02]"
      >
        <i class="fa-solid fa-qrcode"></i> {{ t('student.tuition.payNow') }}
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
const { t } = useI18n();

interface Tuition {
  package: string;
  expiryDate: string;
  debt: string;
}

defineProps<{
  tuition: Tuition;
}>();
</script>
