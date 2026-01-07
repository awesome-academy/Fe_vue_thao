import type { Config } from 'tailwindcss';

export default {
  content: [
    './app/**/*.{js,vue,ts}',
    './components/**/*.{js,vue,ts}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './plugins/**/*.{js,ts}',
    './app.vue',
    './error.vue',
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#2563EB', // Blue-600
          dark: '#1D4ED8', // Blue-700 (Hover)
          light: '#EFF6FF', // Blue-50 (Background)
          soft: '#DBEAFE', // Blue-100 (Accents)
        },
        secondary: '#1E40AF',
        accent: '#F59E0B',
      },
      fontFamily: {
        sans: ['Be Vietnam Pro', 'Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
} satisfies Config;
