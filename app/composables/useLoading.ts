export const useLoading = () => {
  const isLoading = useState('global-loading', () => false);
  const loadingText = useState('global-loading-text', () => 'Đang tải...');

  const startLoading = (text = 'Đang tải...') => {
    loadingText.value = text;
    isLoading.value = true;
  };

  const stopLoading = () => {
    isLoading.value = false;
  };

  return {
    isLoading,
    loadingText,
    startLoading,
    stopLoading,
  };
};
