import { ref, computed } from 'vue';
import { useLoading } from './useLoading';
import { useToast } from 'vue-toastification';
import type { UserModel } from 'app/types/user';
import type { ApiResponseSuccess } from 'app/types/common';
export const useOtp = () => {
  const { startLoading, stopLoading } = useLoading();
  const toast = useToast();
  const { t } = useI18n();
  const config = useRuntimeConfig();
  const apiBase = config.public.apiBase;

  const otpDigits = ref(['', '', '', '', '', '']);
  const otpInputs = ref<HTMLInputElement[]>([]);
  const otpError = ref(false);
  const timer = ref(0);
  const email = ref('');
  let timerInterval: ReturnType<typeof setInterval> | null = null;

  const isOtpComplete = computed(() => {
    return otpDigits.value.every((d) => d !== '');
  });

  const handleOtpInput = (index: number, event: Event) => {
    otpError.value = false;
    const input = event.target as HTMLInputElement;
    const value = input.value;

    // Auto focus next
    if (value && index < 5) {
      otpInputs.value[index + 1]?.focus();
    }
  };

  const handleOtpDelete = (index: number, event: KeyboardEvent) => {
    otpError.value = false;
    const input = event.target as HTMLInputElement;
    // Nếu ô hiện tại rỗng, quay lại ô trước
    if (!input.value && index > 0) {
      otpInputs.value[index - 1]?.focus();
    }
  };

  const handleOtpPaste = (event: ClipboardEvent) => {
    event.preventDefault();
    const pasteData = event.clipboardData?.getData('text').trim() || '';
    if (!/^.{6}$/.test(pasteData)) return;

    const digits = pasteData.split('');
    digits.forEach((d, i) => {
      if (i < 6) otpDigits.value[i] = d;
    });
    otpInputs.value[5]?.focus();
  };

  const verifyOtp = async () => {
    if (!isOtpComplete.value) return;

    startLoading(t('auth.otp.verifying'));
    try {
      const code = otpDigits.value.join('');
      const response: ApiResponseSuccess<UserModel> = await $fetch(
        `${apiBase}/auth/verify-otp`,
        {
          method: 'POST',
          body: { otp: { email: email.value, otp_code: code } },
        }
      );

      toast.success(t('auth.otp.verifySuccess'));
      resetOtp();
      return true;
    } catch (error: any) {
      otpError.value = true;
      switch (error.code) {
        case 'VALIDATION_ERROR':
          toast.error(t('auth.otp.invalidOtp'));
          break;
        default:
          toast.error(error.data?.message || t('auth.otp.verifyError'));
      }
      otpDigits.value = ['', '', '', '', '', ''];
      otpInputs.value[0]?.focus();
      return false;
    } finally {
      stopLoading();
    }
  };

  const startTimer = (seconds: number) => {
    timer.value = seconds;
    if (timerInterval) clearInterval(timerInterval);
    timerInterval = setInterval(() => {
      if (timer.value > 0) timer.value--;
      else if (timerInterval) clearInterval(timerInterval);
    }, 1000);
  };

  const resendOtp = async () => {
    if (timer.value > 0) return;

    startLoading(t('auth.otp.resending'));
    try {
      const response: ApiResponseSuccess<{ message: string }> = await $fetch(
        `${apiBase}/auth/resend-otp`,
        {
          method: 'POST',
          body: { user: { email: email.value } },
        }
      );

      startTimer(60);
      toast.success(t('auth.otp.resendSuccess', { email: email.value }));
    } catch (error: any) {
      switch (error.code) {
        case 'VALIDATION_ERROR':
          toast.error(t('auth.otp.invalidEmailOtp'));
          break;
        default:
          toast.error(error.data?.message || t('auth.otp.resendError'));
      }
    } finally {
      stopLoading();
    }
  };

  const resetOtp = () => {
    otpDigits.value = ['', '', '', '', '', ''];
    otpError.value = false;
    timer.value = 0;
    if (timerInterval) clearInterval(timerInterval);
  };

  watch(email, (newEmail) => {
    email.value = newEmail.trim();
  });

  return {
    otpDigits,
    otpInputs,
    otpError,
    isOtpComplete,
    timer,
    email,
    handleOtpInput,
    handleOtpDelete,
    handleOtpPaste,
    verifyOtp,
    startTimer,
    resendOtp,
    resetOtp,
  };
};
