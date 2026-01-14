<template>
  <div class="w-full h-screen flex relative bg-gray-50 overflow-hidden">
    <!-- LEFT SIDE: Image & Branding (Hidden on mobile) -->
    <div
      class="hidden lg:flex lg:w-1/2 relative bg-secondary text-white items-center justify-center overflow-hidden"
    >
      <div
        class="absolute inset-0 bg-gradient-to-br from-blue-900/90 to-primary/80 z-10"
      ></div>
      <img
        src="https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80"
        class="absolute inset-0 w-full h-full object-cover mix-blend-overlay"
        alt="Education Background"
      />

      <div class="relative z-20 p-12 text-center max-w-lg">
        <div
          class="mb-6 inline-flex items-center justify-center w-20 h-20 rounded-full bg-white/10 backdrop-blur-md border border-white/20"
        >
          <i class="fas fa-graduation-cap text-4xl"></i>
        </div>
        <h1 class="text-4xl font-bold mb-4">TMS Education</h1>
        <p class="text-blue-100 text-lg leading-relaxed">
          {{ $t('auth.leftSide.description') }}
        </p>

        <div class="mt-12 grid grid-cols-3 gap-4 text-sm">
          <div class="bg-white/10 p-4 rounded-lg backdrop-blur-sm">
            <i class="fas fa-chart-line text-2xl mb-2 text-accent"></i>
            <p>{{ $t('auth.leftSide.trackProgress') }}</p>
          </div>
          <div class="bg-white/10 p-4 rounded-lg backdrop-blur-sm">
            <i class="fas fa-calendar-check text-2xl mb-2 text-accent"></i>
            <p>{{ $t('auth.leftSide.onlineAttendance') }}</p>
          </div>
          <div class="bg-white/10 p-4 rounded-lg backdrop-blur-sm">
            <i class="fas fa-file-invoice-dollar text-2xl mb-2 text-accent"></i>
            <p>{{ $t('auth.leftSide.manageTuition') }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- RIGHT SIDE: Form Container -->
    <div
      class="w-full lg:w-1/2 flex items-center justify-center p-4 sm:p-12 bg-white relative"
    >
      <!-- Transition between Auth Form and OTP Form -->
      <Transition name="fade" mode="out-in">
        <!-- Auth Form (Login/Register) -->
        <div v-if="!showOtp" class="w-full max-w-md space-y-8" key="auth-form">
          <!-- Mobile Logo -->
          <MobileLogo />

          <!-- Header Text -->
          <AuthHeader :isLogin="isLogin" />

          <!-- FORM -->
          <form class="mt-8 space-y-6" @submit.prevent="handleAuthSubmit">
            <!-- Input Fields -->
            <AuthInputFields
              :isLogin="isLogin"
              :showPassword="showPassword"
              :form="form"
              @toggle-password="showPassword = !showPassword"
            />

            <!-- Remember Me & Forgot Password -->
            <AuthRememberMe :isLogin="isLogin" />

            <!-- Submit Button -->
            <AuthSubmitButton :isLogin="isLogin" />

            <!-- Social Login -->
            <AuthSocialLogin @google-login="authStore.googleLogin('Google')" />
          </form>

          <!-- Switcher -->
          <AuthToggle :isLogin="isLogin" @toggle="toggleMode" />

          <!-- Footer Info -->
          <AuthFooter />
        </div>

        <!-- OTP Form -->
        <AuthOtpForm
          v-else
          :email="form.email"
          @back="showOtp = false"
          @success="handleOtpSuccess"
          key="otp-form"
        />
      </Transition>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useToast } from 'vue-toastification';

definePageMeta({
  layout: 'auth',
});

const showOtp = ref(false);
const { t } = useI18n();
const toast = useToast();
const { startLoading, stopLoading } = useLoading();

const authStore = useAuthStore();
const { form, isLogin, toggleMode, resetForm, showPassword } = useAuthForm();

const handleAuthSubmit = async () => {
  if (form.email === '' || form.password === '') {
    toast.error(t('auth.messages.fillAllFields'));
    return;
  }
  if (!isLogin.value && form.full_name === '') {
    toast.error(t('auth.messages.fillAllFields'));
    return;
  }
  startLoading(
    isLogin.value ? t('auth.messages.loggingIn') : t('auth.messages.signingUp')
  );

  try {
    if (isLogin.value) {
      await authStore.login(form.email, form.password);
      toast.success(t('auth.messages.loginSuccessMsg'));
      navigateTo(authStore.role === 'student' ? '/student' : '/teacher');
    } else {
      const { register } = useAuthApi();
      await register(form);
      showOtp.value = true;
      toast.success(t('auth.messages.signupSuccessOtp'));
    }
  } catch (e) {
    if (isLogin.value) {
      toast.error(getErrorMessage(e, 'auth.login', t));
    } else {
      toast.error(getErrorMessage(e, 'auth.register', t));
    }
  } finally {
    stopLoading();
  }
};

const handleOtpSuccess = () => {
  showOtp.value = false;
  // Reset form and show login message
  resetForm();
  isLogin.value = true;
  navigateTo('/auth');
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
