import type { Ref } from 'vue';

interface StudentClass {
  timeStart: string;
  subject: string;
  teacher: string;
  room: string;
  status: 'dropped' | 'live' | 'upcoming';
}

export interface Assignment {
  title: string;
  class: string;
  dueDate: string;
  isUrgent: boolean;
  status: string;
}

export interface Tuition {
  package: string;
  expiryDate: string;
  debt: string;
}

export interface StudentInfo {
  name: string;
  avatar: string;
  class: string;
}

export interface DashboardData {
  student: StudentInfo;
  classes: StudentClass[];
  assignments: Assignment[];
  tuition: Tuition;
  stats: Array<{
    icon: string;
    color: string;
    title: string;
    value: string;
    subtitle: string;
  }>;
}

export const useDashboard = (): {
  debugMode: Ref<boolean>;
  studentInfo: Ref<StudentInfo>;
  todayClasses: Ref<StudentClass[]>;
  pendingAssignments: Ref<Assignment[]>;
  tuitionData: Ref<Tuition>;
  stats: Ref<DashboardData['stats']>;
} => {
  const debugMode = ref(false);

  const studentInfo = ref<StudentInfo>({
    name: 'Trần Văn Minh',
    avatar:
      'https://ui-avatars.com/api/?name=Tran+Minh&background=2563EB&color=fff',
    class: 'Học sinh Lớp 12',
  });

  const todayClasses = ref<StudentClass[]>([
    {
      timeStart: '17:30',
      subject: 'Toán Cao Cấp (Đại số)',
      teacher: 'Thầy Nguyễn Văn A',
      room: 'P.302',
      status: 'live',
    },
    {
      timeStart: '19:15',
      subject: 'Luyện thi IELTS',
      teacher: 'Ms. Sarah',
      room: 'Zoom Online',
      status: 'upcoming',
    },
  ]);

  const pendingAssignments = ref<Assignment[]>([
    {
      title: 'Bài tập Đại số tuyến tính',
      class: 'Toán 12A',
      dueDate: '20:00 Tối nay',
      isUrgent: true,
      status: 'Chưa nộp',
    },
    {
      title: 'Viết lại bài luận Task 2',
      class: 'Tiếng Anh',
      dueDate: '09/01/2024',
      isUrgent: false,
      status: 'Đang làm',
    },
    {
      title: 'Trắc nghiệm Vật Lý',
      class: 'Lý 12',
      dueDate: '10/01/2024',
      isUrgent: false,
      status: 'Đang làm',
    },
  ]);

  const tuitionData = ref<Tuition>({
    package: 'Toán + Anh (Combo)',
    expiryDate: '15/01/2024',
    debt: '2.500.000đ',
  });

  const stats = ref<DashboardData['stats']>([
    {
      icon: 'fa-user-check',
      color: 'text-blue-600 bg-blue-100',
      title: 'Điểm danh',
      value: '95%',
      subtitle: 'Vắng 1 buổi (Có phép)',
    },
    {
      icon: 'fa-chart-line',
      color: 'text-emerald-600 bg-emerald-100',
      title: 'Điểm TB',
      value: '8.5',
      subtitle: 'Tăng 0.5 so với giữa kỳ',
    },
    {
      icon: 'fa-book',
      color: 'text-orange-600 bg-orange-100',
      title: 'Bài tập',
      value: '12',
      subtitle: 'Đã hoàn thành tốt',
    },
    {
      icon: 'fa-wallet',
      color: 'text-purple-600 bg-purple-100',
      title: 'Số dư ví',
      value: '200k',
      subtitle: 'Hạn gói: 15/02',
    },
  ]);

  return {
    debugMode,
    studentInfo,
    todayClasses,
    pendingAssignments,
    tuitionData,
    stats,
  };
};
