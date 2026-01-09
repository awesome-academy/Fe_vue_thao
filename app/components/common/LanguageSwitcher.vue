<template>
  <div class="flex items-center gap-2">
    <button @click="changeLanguage('vi')" :class="buttonClass('vi')">
      Tiếng Việt
    </button>

    <button @click="changeLanguage('en')" :class="buttonClass('en')">
      English
    </button>
  </div>
</template>

<script setup lang="ts">
const { locale, setLocale } = useI18n();

const changeLanguage = (lang: 'vi' | 'en') => {
  setLocale(lang);
};

const buttonClass = (lang: string) => [
  'px-3 py-1 rounded-md transition-colors font-medium',
  locale.value === lang
    ? 'bg-blue-600 text-white'
    : 'bg-gray-200 text-gray-700 hover:bg-gray-300',
];
</script>
