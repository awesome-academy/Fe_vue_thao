<template>
  <div class="space-y-4">
    <!-- Name Field (Register Only) -->
    <div v-if="!isLogin">
      <label for="name" class="block text-sm font-medium text-gray-700">{{
        $t('auth.form.fullName')
      }}</label>
      <div class="mt-1 relative rounded-md shadow-sm">
        <div
          class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
        >
          <i class="fas fa-user text-gray-400"></i>
        </div>
        <input
          v-model="form.full_name"
          id="full_name"
          name="full_name"
          type="text"
          required
          class="focus:ring-primary focus:border-primary block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 border"
          :placeholder="$t('auth.form.namePlaceholder')"
        />
      </div>
    </div>

    <!-- Email Field -->
    <div>
      <label for="email" class="block text-sm font-medium text-gray-700">{{
        $t('auth.form.email')
      }}</label>
      <div class="mt-1 relative rounded-md shadow-sm">
        <div
          class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
        >
          <i class="fas fa-envelope text-gray-400"></i>
        </div>
        <input
          v-model="form.email"
          id="email"
          name="email"
          type="email"
          autocomplete="email"
          required
          class="focus:ring-primary focus:border-primary block w-full pl-10 sm:text-sm border-gray-300 rounded-md py-2 border"
          :placeholder="
            $t('auth.form.emailPlaceholder', { email: 'example@tms.edu.vn' })
          "
        />
      </div>
    </div>

    <!-- Password Field -->
    <div>
      <label for="password" class="block text-sm font-medium text-gray-700">{{
        $t('auth.form.password')
      }}</label>
      <div class="mt-1 relative rounded-md shadow-sm">
        <div
          class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
        >
          <i class="fas fa-lock text-gray-400"></i>
        </div>
        <input
          v-model="form.password"
          id="password"
          name="password"
          :type="showPassword ? 'text' : 'password'"
          autocomplete="current-password"
          required
          class="focus:ring-primary focus:border-primary block w-full pl-10 pr-10 sm:text-sm border-gray-300 rounded-md py-2 border"
          :placeholder="$t('auth.form.passwordPlaceholder')"
        />
        <div
          class="absolute inset-y-0 right-0 pr-3 flex items-center cursor-pointer"
          @click="$emit('toggle-password')"
        >
          <i
            class="fas text-gray-400"
            :class="showPassword ? 'fa-eye-slash' : 'fa-eye'"
          ></i>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  isLogin: boolean;
  showPassword: boolean;
  form: AuthForm;
}>();

defineEmits<{
  'toggle-password': [];
}>();
</script>
