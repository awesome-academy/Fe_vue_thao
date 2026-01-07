import { defineStore } from 'pinia';
import type { UserModel } from 'app/types/user';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null as UserModel | null,
    token: null as string | null,
  }),

  getters: {
    isAuthenticated: (s) => !!s.token,
    role: (s) => s.user?.role,
  },

  actions: {
    async login(email: string, password: string) {
      const { login } = useAuthApi();
      const res = await login(email, password);

      this.token = res.data.token;
      this.user = res.data.user;

      useCookie('auth_token', {
        maxAge: 60 * 60 * 24 * 7,
      }).value = this.token;
    },

    async googleLogin(provider: string) {
      const { googleLogin } = useAuthApi();
      const res = await googleLogin(provider);

      this.token = res.data.token;
      this.user = res.data.user;

      useCookie('auth_token').value = this.token;
    },

    logout() {
      useCookie('auth_token').value = null;
      this.$reset();
    },
  },
});
