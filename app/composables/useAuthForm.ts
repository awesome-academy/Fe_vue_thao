import { ref, reactive } from 'vue';

export interface AuthForm {
  email: string;
  password: string;
  full_name: string;
  role: string;
}

export const useAuthForm = () => {
  const isLogin = ref(true);
  const showPassword = ref(false);

  const form = reactive<AuthForm>({
    email: '',
    password: '',
    full_name: '',
    role: 'student',
  });

  const toggleMode = () => {
    isLogin.value = !isLogin.value;
    form.password = '';
  };

  const resetForm = () => {
    Object.assign(form, {
      email: '',
      password: '',
      full_name: '',
      role: 'student',
    });
  };

  return {
    isLogin,
    showPassword,
    form,
    toggleMode,
    resetForm,
  };
};
