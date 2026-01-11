/**
 * Class-related types and interfaces
 */

import type { PaginationInfo } from './common';

export interface ClassSchedule {
  monday?: string;
  tuesday?: string;
  wednesday?: string;
  thursday?: string;
  friday?: string;
  saturday?: string;
  sunday?: string;
}

export interface Class {
  id: number;
  name: string;
  subject: string;
  grade_level: string;
  fee_per_session: string | number;
  teacher: string | null;
  schedule: ClassSchedule;
  student_count: number;
  created_at: string; // ISO date string
  updated_at: string; // ISO date string
}

export interface StudentClass {
  id: string;
  code: string;
  name: string;
  teacher: string;
  schedule: string;
  room: string;
  attended: number;
  totalSessions: number;
  class_id: number;
  status: 'dropped' | 'pending' | 'active';
}

export interface DailyScheduleClass {
  timeStart: string;
  subject: string;
  teacher: string;
  room: string;
  status: 'live' | 'upcoming';
}

export interface ClassDetail extends Class {
  description?: string;
  max_students?: number;
  room?: string;
  status?: 'active' | 'inactive' | 'completed';
  duration_per_session?: number; // minutes
  total_sessions?: number;
  attended_sessions?: number;
}

export interface ClassCard extends Class {
  code?: string;
  room?: string;
  attended?: number;
  totalSessions?: number;
}

export interface AvailableClass {
  id: number;
  name: string;
  teacher: string;
  schedule: string;
  price: string;
  slots: number;
  tags: string[];
  subject?: string;
  grade_level?: string;
}

export interface ClassFilterParams {
  search?: string;
  subject?: string;
  grade_level?: string;
  sort?: 'name' | 'fee_per_session' | 'student_count';
  order?: 'asc' | 'desc';
  page?: number;
  limit?: number;
}

export interface ClassListResponse {
  classes: Class[];
  pagination: PaginationInfo;
}

export interface RegisterClassRequest {
  classId: number;
}

export interface RegisterClassResponse {
  success: boolean;
  message: string;
  data?: Class;
}

export interface LeaveClassRequest {
  classId: string | number;
  reason: string;
  leave_date?: string;
}

export interface LeaveClassResponse {
  success: boolean;
  message: string;
}

export interface ClassStatistics {
  totalClasses: number;
  activeClasses: number;
  totalStudents: number;
  totalRevenue: number;
  averageStudentsPerClass: number;
}
