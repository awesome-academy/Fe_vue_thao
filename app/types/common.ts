/**
 * Common types for the application
 */

export interface ApiResponseSuccess<T> {
  data: T;
  success: boolean;
}

export interface ApiResponseError {
  error: {
    code: string;
    message: string;
    details?: any;
  };
  success: boolean;
}
export interface PageMeta {
  title: string;
  description?: string;
}

export interface PaginationParams {
  page: number;
  limit: number;
  sort?: string;
  order?: 'asc' | 'desc';
}

export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  page: number;
  limit: number;
  pages: number;
}
