export const handleAuthError = (e: unknown, title: string) => {
  if ((e as any)?.data?.error) {
    const errorCode = (e as any).data.error.code;

    switch (errorCode) {
      case 'UNAUTHORIZED':
        return `${title}.messages.unauthorizedError`;
      case 'VALIDATION_ERROR':
        return `${title}.messages.validationError`;
      case 'NOT_FOUND':
        return `${title}.messages.notFoundError`;
      default:
        return `${title}.messages.loginFailedError`;
    }
  } else {
    return 'common.errors.networkError';
  }
};

export const getAuthHeader = (): Record<string, string> => {
  const token = useCookie('auth_token').value;
  if (!token) return {};

  return {
    Authorization: `Bearer ${token}`,
  };
};
