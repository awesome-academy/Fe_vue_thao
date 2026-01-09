// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',

  // SSR
  ssr: true,

  // Typescript
  typescript: {
    strict: true,
    typeCheck: false,
  },

  // App configuration
  app: {
    head: {
      title: 'Education Class Manager',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content: 'Quản lý lớp học hiệu quả',
        },
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        {
          rel: 'stylesheet',
          href: 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css',
        },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        {
          rel: 'preconnect',
          href: 'https://fonts.gstatic.com',
          crossorigin: '',
        },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap',
        },
      ],
    },
  },

  // Alias
  alias: {
    '@': './app',
  },

  // CSS
  css: ['@/assets/styles/global.css'],

  // App directory
  srcDir: 'app',

  // Runtime config
  runtimeConfig: {
    public: {
      apiBase: process.env.API_BASE || '/api/v1',
      googleClientId:
        process.env.GOOGLE_CLIENT_ID ||
        'your-google-client-id.apps.googleusercontent.com',
    },
  },

  // Modules
  modules: ['@nuxtjs/tailwindcss', '@nuxtjs/i18n', '@pinia/nuxt'],
  i18n: {
    defaultLocale: 'vi',
    strategy: 'no_prefix',

    locales: [
      { code: 'vi', name: 'Tiếng Việt', file: 'vi.json' },
      { code: 'en', name: 'English', file: 'en.json' },
    ],

    langDir: '../locales',
  },

  // Nitro configuration
  nitro: {
    prerender: {
      crawlLinks: false,
    },
    routeRules: {
      '/api/**': { proxy: 'http://localhost:3000/api/**' },
    },
  },

  // Build
  build: {
    transpile: [],
  },

  // Development
  devtools: {
    enabled: true,
  },
});
