export type ErrorCode =
  | 'VALIDATION_ERROR'
  | 'UNAUTHORIZED'
  | 'FORBIDDEN'
  | 'NOT_FOUND'
  | 'BAD_REQUEST'
  | 'INTERNAL_ERROR'
  | 'ERROR';

export function mapStatusToErrorCode(status: number): ErrorCode {
  switch (status) {
    case 400:
      return 'BAD_REQUEST';
    case 401:
      return 'UNAUTHORIZED';
    case 403:
      return 'FORBIDDEN';
    case 404:
      return 'NOT_FOUND';
    case 422:
      return 'VALIDATION_ERROR';
    case 500:
      return 'INTERNAL_ERROR';
    default:
      return 'ERROR';
  }
}

export function getErrorMessageKey(
  module: string,
  errorCode: ErrorCode
): string {
  return `${module}.errors.${errorCode}`;
}

export function parseApiError(error: any, module: string): string {
  const status = error?.response?.status || error?.status || 500;
  const errorCode = mapStatusToErrorCode(status);
  return getErrorMessageKey(module, errorCode);
}

export function getErrorMessage(
  error: any,
  module: string,
  t: (key: string) => string
): string {
  const errorKey = parseApiError(error, module);
  return t(errorKey);
}

export function isErrorCode(error: any, errorCode: ErrorCode): boolean {
  const status = error?.response?.status || error?.status;
  return mapStatusToErrorCode(status) === errorCode;
}

export const ErrorChecks = {
  isValidationError: (error: any) => isErrorCode(error, 'VALIDATION_ERROR'),
  isUnauthorized: (error: any) => isErrorCode(error, 'UNAUTHORIZED'),
  isForbidden: (error: any) => isErrorCode(error, 'FORBIDDEN'),
  isNotFound: (error: any) => isErrorCode(error, 'NOT_FOUND'),
  isBadRequest: (error: any) => isErrorCode(error, 'BAD_REQUEST'),
  isServerError: (error: any) => isErrorCode(error, 'INTERNAL_ERROR'),
};
