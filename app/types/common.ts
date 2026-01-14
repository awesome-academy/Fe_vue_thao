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
  perPage: number;
  sort?: string;
  order?: 'asc' | 'desc';
}

export interface PaginationInfo {
  current_page: number;
  per_page: number;
  total_count: number;
  total_pages: number;
}
