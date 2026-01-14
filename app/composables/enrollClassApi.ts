import type { ApiResponseSuccess } from 'app/types/common';

export const useEnrollClassApi = () => {
  const config = useRuntimeConfig();
  const apiBase = config.public.apiBase;

  const registerClass = (classId: number) =>
    $fetch<ApiResponseSuccess<string>>(`${apiBase}/classes/${classId}/enroll`, {
      method: 'POST',
      headers: getAuthHeader(),
    });
  const quitClass = (classId: number) =>
    $fetch<ApiResponseSuccess<string>>(`${apiBase}/classes/${classId}/quit`, {
      method: 'DELETE',
      headers: getAuthHeader(),
    });

  const leaveRequestClass = (
    classId: number,
    reason: string,
    leaveType: string,
    date?: string
  ) =>
    $fetch<ApiResponseSuccess<string>>(
      `${apiBase}/classes/${classId}/leave_requests`,
      {
        method: 'POST',
        headers: getAuthHeader(),
        body: {
          leave_request: {
            date: date || null,
            reason,
            leave_type: leaveType,
          },
        },
      }
    );

  return {
    registerClass,
    quitClass,
    leaveRequestClass,
  };
};
