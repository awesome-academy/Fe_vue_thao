<template>
  <div
    class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50"
  >
    <div
      class="max-w-md w-full space-y-8 bg-white p-10 rounded-xl shadow-lg border border-gray-100"
    >
      <!-- Header Section -->
      <div class="text-center">
        <div
          class="mx-auto h-16 w-16 bg-blue-600 text-white flex items-center justify-center rounded-full text-2xl font-bold mb-4 shadow-md"
        >
          TMS
        </div>
        <h2 class="mt-2 text-3xl font-extrabold text-gray-900">
          Quên mật khẩu?
        </h2>
        <p class="mt-2 text-sm text-gray-600">
          Đừng lo lắng! Hãy nhập email đã đăng ký của bạn, chúng tôi sẽ gửi mật
          khẩu mới đến email của bạn.
        </p>
      </div>

      <!-- Form Section -->
      <form class="mt-8 space-y-6" @submit.prevent="handleSubmit">
        <!-- Input Group -->
        <div class="rounded-md shadow-sm">
          <div>
            <label for="email-address" class="sr-only">Địa chỉ Email</label>
            <input
              id="email-address"
              v-model="form.email"
              name="email"
              type="email"
              autocomplete="email"
              :disabled="isLoading"
              class="appearance-none rounded-md relative block w-full px-4 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-blue-500 focus:border-blue-500 focus:z-10 sm:text-sm transition-colors duration-200 disabled:bg-gray-100"
              placeholder="Nhập email của bạn (ví dụ: phuhuynh@gmail.com)"
            />
          </div>
        </div>

        <!-- Action Buttons -->
        <div>
          <button
            type="submit"
            :disabled="isLoading"
            class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:bg-blue-300 disabled:cursor-not-allowed transition-all duration-200 shadow-md hover:shadow-lg"
          >
            <span class="absolute left-0 inset-y-0 flex items-center pl-3">
              <!-- Loading Spinner -->
              <svg
                v-if="isLoading"
                class="animate-spin h-5 w-5 text-white"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  class="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  stroke-width="4"
                ></circle>
                <path
                  class="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                ></path>
              </svg>
              <!-- Lock Icon -->
              <svg
                v-else
                class="h-5 w-5 text-blue-500 group-hover:text-blue-400 transition-colors"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z"
                  clip-rule="evenodd"
                />
              </svg>
            </span>
            {{ isLoading ? 'Đang xử lý...' : 'Gửi liên kết khôi phục' }}
          </button>
        </div>

        <!-- Navigation Links -->
        <div class="flex items-center justify-center text-sm">
          <NuxtLink
            to="/auth"
            class="font-medium text-blue-600 hover:text-blue-500 flex items-center gap-1 transition-colors"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-4 w-4"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M10 19l-7-7m0 0l7-7m-7 7h18"
              />
            </svg>
            Quay lại trang Đăng nhập
          </NuxtLink>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: false,
});

const { form, handleSubmit, isLoading } = useForgotPassword();
</script>

<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fadeIn 0.3s ease-out forwards;
}
</style>
