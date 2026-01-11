import type { ClassListResponse } from 'app/types/class';
import type { ApiResponseSuccess, PaginationInfo } from 'app/types/common';

interface ClassParams {
  page: number;
  perPage: number;
  subject?: string;
  search?: string;
}

export interface StudentClassResponse {
  id: number;
  class_id: number;
  class_name: string;
  teacher_name: string;
  schedule: Record<string, string>;
  student_id: number;
  student_name: string;
  joined_at: string | null;
  status: string;
  tuition_debt: number;
  sessions_attended: number;
  created_at: string;
  updated_at: string;
}

export interface StudentClassesResponse {
  classes: StudentClassResponse[];
  pagination: PaginationInfo;
}

export const useClassApi = () => {
  const config = useRuntimeConfig();
  const apiBase = config.public.apiBase;

  const fetchClasses = (params: ClassParams) =>
    $fetch<ApiResponseSuccess<ClassListResponse>>(`${apiBase}/classes`, {
      method: 'GET',
      params,
      headers: getAuthHeader(),
    });

  const fetchSubjects = () =>
    $fetch<ApiResponseSuccess<string[]>>(`${apiBase}/classes/subjects`, {
      method: 'GET',
      headers: getAuthHeader(),
    });

  const fetchStudentClasses = (params?: { page?: number; per_page?: number }) =>
    $fetch<ApiResponseSuccess<StudentClassesResponse>>(
      `${apiBase}/classes/student_class`,
      {
        method: 'GET',
        params,
        headers: getAuthHeader(),
      }
    );

  return {
    fetchClasses,
    fetchSubjects,
    fetchStudentClasses,
  };
};
