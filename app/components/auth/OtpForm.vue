<template>
  <div class="w-full max-w-md space-y-8">
    <!-- Header -->
    <div class="text-center">
      <div
        class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-blue-100 mb-4"
      >
        <i class="fas fa-shield-alt text-2xl text-primary"></i>
      </div>
      <h2 class="text-2xl font-bold text-gray-900">
        {{ $t('auth.otp.title') }}
      </h2>
      <p class="mt-2 text-sm text-gray-500">
        {{ $t('auth.otp.description') }} <br />
        <span class="font-medium text-gray-900">{{ emailProp }}</span>
      </p>
    </div>

    <div class="mt-8">
      <!-- OTP Inputs -->
      <div class="flex justify-between gap-2 mb-6" :class="{ shake: otpError }">
        <input
          v-for="(digit, idx) in otpDigits"
          :key="idx"
          :ref="(el) => otpInputs[idx] = el as HTMLInputElement"
          v-model="otpDigits[idx]"
          type="text"
          inputmode="text"
          maxlength="6"
          @input="handleOtpInput(idx, $event)"
          @keydown.delete="handleOtpDelete(idx, $event)"
          @paste="handleOtpPaste"
          class="w-12 h-12 text-center text-xl font-bold border-2 rounded-lg focus:border-primary focus:ring-primary outline-none transition-all"
          :class="
            otpError
              ? 'border-red-500 text-red-600'
              : 'border-gray-300 text-gray-900'
          "
        />
      </div>

      <p v-if="otpError" class="text-center text-sm text-red-500 mb-4">
        {{ $t('auth.otp.error') }}
      </p>

      <button
        @click="verifyOtp"
        :disabled="!isOtpComplete"
        class="w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-primary hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary disabled:opacity-50 disabled:cursor-not-allowed transition-all shadow-md"
      >
        {{ $t('auth.buttons.confirm') }}
      </button>

      <div class="mt-6 text-center text-sm">
        <p class="text-gray-500">{{ $t('auth.otp.noCode') }}</p>
        <button
          @click="resendOtp"
          :disabled="timer > 0"
          class="mt-1 font-medium transition-colors"
          :class="
            timer > 0
              ? 'text-gray-400 cursor-not-allowed'
              : 'text-primary hover:text-blue-500'
          "
        >
          {{
            timer > 0
              ? $t('auth.otp.resendTimer', { timer })
              : $t('auth.otp.resend')
          }}
        </button>
      </div>

      <div class="mt-8 text-center">
        <button
          @click="$emit('back')"
          class="text-sm text-gray-500 hover:text-gray-900 flex items-center justify-center w-full"
        >
          <i class="fas fa-arrow-left mr-2"></i> {{ $t('auth.otp.back') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';

const { email: emailProp } = defineProps<{
  email: string;
}>();

const emit = defineEmits<{
  back: [];
  success: [];
}>();

const {
  otpDigits,
  otpInputs,
  otpError,
  isOtpComplete,
  timer,
  email,
  handleOtpInput,
  handleOtpDelete,
  handleOtpPaste,
  verifyOtp: verify,
  startTimer,
  resendOtp,
} = useOtp();

const verifyOtp = async () => {
  const success = await verify();
  if (success) {
    emit('success');
  }
};

onMounted(() => {
  email.value = emailProp;
  startTimer(60);
  otpInputs.value[0]?.focus();
});
</script>

<style scoped>
.shake {
  animation: shake 0.82s cubic-bezier(0.36, 0.07, 0.19, 0.97) both;
}

@keyframes shake {
  10%,
  90% {
    transform: translate3d(-1px, 0, 0);
  }
  20%,
  80% {
    transform: translate3d(2px, 0, 0);
  }
  30%,
  50%,
  70% {
    transform: translate3d(-4px, 0, 0);
  }
  40%,
  60% {
    transform: translate3d(4px, 0, 0);
  }
}
</style>
