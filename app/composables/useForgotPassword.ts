import { ref, reactive } from 'vue';
import { useToast } from 'vue-toastification';

export interface ForgotPasswordForm {
  email: string;
}

export const useForgotPassword = () => {
  const form = reactive<ForgotPasswordForm>({
    email: '',
  });

  const config = useRuntimeConfig();
  const apiBase = config.public.apiBase;
  const toast = useToast();
  const { t } = useI18n();
  const isLoading = ref(false);

  const isValidEmail = (email: string) => {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  };

  const handleSubmit = async () => {
    if (!form.email) {
      toast.error(t('auth.forgotPassword.emailRequired'));
      return;
    }

    if (!isValidEmail(form.email)) {
      toast.error(t('auth.forgotPassword.invalidEmail'));
      return;
    }
    isLoading.value = true;
    try {
      const endpoint = `${apiBase}/auth/forget-password`;
      await $fetch(endpoint, {
        method: 'POST',
        body: { user: { email: form.email } },
      });
      form.email = '';
      toast.success(t('auth.forgotPassword.successMessage'));
    } catch (error: any) {
      const errorCode = error.data?.error?.code;

      switch (errorCode) {
        case 'VALIDATION_ERROR':
          toast.error(t('auth.forgotPassword.validationError'));
          break;
        default:
          toast.error(t('auth.forgotPassword.errorMessage'));
      }
    } finally {
      isLoading.value = false;
    }
  };

  const resetForm = () => {
    form.email = '';
  };

  return {
    form,
    handleSubmit,
    resetForm,
    isLoading,
  };
};
