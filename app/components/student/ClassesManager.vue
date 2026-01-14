<template>
  <div class="h-full flex flex-col space-y-6">
    <!-- Toolbar -->
    <StudentClassesToolbar
      :view-mode="viewMode"
      @switch-view="viewMode = $event"
      @back="viewMode = 'list'"
    />

    <!-- View 1: List View -->
    <div v-if="viewMode === 'list'" class="flex flex-col gap-6">
      <StudentClassesListView
        :classes="classes"
        @request-leave="handleRequestLeave"
        @makeup-class="handleMakeupClass"
        @add-new="viewMode = 'register'"
      />
      <!-- Pagination for My Classes -->
      <CommonPagination
        v-if="myClassesTotalItemsComputed > myClassesPerPage"
        :current-page="myClassesPage"
        :total-pages="myClassesTotalPagesComputed"
        :items-per-page="myClassesPerPage"
        :total-items="myClassesTotalItemsComputed"
        @update:current-page="$emit('update:my-classes-page', $event)"
        @update:items-per-page="$emit('update:my-classes-per-page', $event)"
      />
    </div>

    <!-- View 2: Calendar View -->
    <StudentClassesCalendarView
      v-else-if="viewMode === 'calendar'"
      :schedule-data="scheduleData"
    />

    <!-- View 3: Register New Class (COURSE CATALOG) -->
    <StudentClassesRegisterView
      v-else-if="viewMode === 'register'"
      :available-classes="availableClasses"
      :error="error"
      :pending="pending"
      :refresh="refresh"
      :subjects="subjects"
      :search-query="searchQuery"
      :subject="subject"
      :page="availablePage"
      :per-page="availablePerPage"
      :total-pages="props.availableTotalPages"
      :total-items="props.availableTotalItems"
      @update:search-query="searchQuery = $event"
      @update:subject="subject = $event"
      @update:page="availablePage = $event"
      @update:per-page="availablePerPage = $event"
      @register="handleRegister"
    />

    <!-- Leave Request Modal -->
    <StudentLeaveRequestModal
      v-model="showLeaveModal"
      :selected-class="selectedClass"
      @submit="submitLeaveRequest"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useToast } from 'vue-toastification';
import { useI18n } from 'vue-i18n';
import type { Class, StudentClass } from 'app/types/class';
interface ScheduleEvent {
  time: string;
  subject: string;
  room: string;
  type: string;
}

const props = defineProps<{
  classes: StudentClass[];
  availableClasses: Class[];
  error: any;
  pending: boolean;
  refresh: () => void;
  subjects: string[];
  subjectsPending: boolean;
  availableTotalPages: number;
  availableTotalItems: number;
  myClassesPage: number;
  myClassesPerPage: number;
  myClassesTotalPages: number;
  myClassesTotalItems: number;
  refreshStudentClasses: () => void;
}>();

const searchQuery = defineModel<string>('searchQuery', { default: '' });
const subject = defineModel<string | undefined>('subject', {
  default: undefined,
});
const availablePage = defineModel<number>('availablePage', { default: 1 });
const availablePerPage = defineModel<number>('availablePerPage', {
  default: 20,
});

const emit = defineEmits<{
  'update:my-classes-page': [page: number];
  'update:my-classes-per-page': [perPage: number];
}>();

const { t } = useI18n();
const toast = useToast();

const viewMode = ref<'list' | 'calendar' | 'register'>('list');
const showLeaveModal = ref(false);
const selectedClass = ref<StudentClass | null>(null);
const { startLoading, stopLoading } = useLoading();

// Computed properties for my classes pagination
const myClassesTotalPagesComputed = computed(() => {
  return props.myClassesTotalPages || 1;
});

const myClassesTotalItemsComputed = computed(() => {
  return props.myClassesTotalItems || 0;
});

const scheduleData = computed<ScheduleEvent[][]>(() => {
  if (!props.classes || props.classes.length === 0) {
    return Array(7).fill([]);
  }

  const weekSchedule: ScheduleEvent[][] = Array(7)
    .fill(null)
    .map(() => []);

  props.classes.forEach((cls) => {
    if (cls.status !== 'active') return;
    const scheduleStr = cls.schedule || '';
    if (!scheduleStr) return;

    const colonIndex = scheduleStr.indexOf(':');
    let daysPart = '';
    let time = '';

    if (colonIndex !== -1) {
      daysPart = scheduleStr.substring(0, colonIndex);
      time = scheduleStr.substring(colonIndex + 1).trim();
    } else {
      daysPart = scheduleStr;
      time = '';
    }

    const scheduledDays = daysPart
      .split(',')
      .map((d) => d.trim())
      .filter((d) => d);

    const dayMap = {
      T2: 0,
      T3: 1,
      T4: 2,
      T5: 3,
      T6: 4,
      T7: 5,
      CN: 6,
    };

    scheduledDays.forEach((day) => {
      const dayIndex = dayMap[day as keyof typeof dayMap];
      if (dayIndex !== undefined) {
        const event: ScheduleEvent = {
          time,
          subject: cls.name,
          room: cls.room || 'TBD',
          type: 'blue',
        };
        weekSchedule[dayIndex]!.push(event);
      }
    });
  });

  return weekSchedule;
});

// Schedule data for calendar view (fallback empty state)

const handleRequestLeave = async (cls: StudentClass) => {
  if (cls.status === 'pending') {
    if (
      confirm(t('student.classes.confirmCancelEnroll', { className: cls.name }))
    ) {
      try {
        startLoading(t('student.classes.leaving'));
        await useEnrollClassApi().quitClass(cls.class_id);
        toast.success(t('student.classes.leave.cancelSuccess'));
        props.refresh();
        props.refreshStudentClasses();
      } catch (error) {
        toast.error(
          getErrorMessage(error, 'student.classes.leave.cancelError', t)
        );
      } finally {
        stopLoading();
      }
    }
  } else {
    selectedClass.value = cls;
    showLeaveModal.value = true;
  }
};

const handleMakeupClass = (cls: StudentClass) => {
  toast.info(t('student.classes.actions.makeupInfo'));
};

const handleRegister = async (course: Class) => {
  if (
    confirm(t('student.classes.confirmRegister', { className: course.name }))
  ) {
    try {
      await useEnrollClassApi().registerClass(course.id);
      toast.success(t('student.classes.registerSuccess'));
      viewMode.value = 'list';
      props.refresh();
      props.refreshStudentClasses();
    } catch (error) {
      toast.error(getErrorMessage(error, 'student.classes.registerError', t));
    }
  }
};

const submitLeaveRequest = async (payload: {
  date: string;
  reason: string;
  leaveType: string;
}) => {
  if (!selectedClass.value) return;

  try {
    startLoading(t('student.classes.submittingLeave'));
    await useEnrollClassApi().leaveRequestClass(
      selectedClass.value.class_id,
      payload.reason,
      payload.leaveType,
      payload.date
    );
    toast.success(t('student.classes.leave.successMessage'));
    showLeaveModal.value = false;
    selectedClass.value = null;
  } catch (error) {
    toast.error(
      getErrorMessage(error, 'student.classes.leave.errorSubmitting', t)
    );
  } finally {
    stopLoading();
  }
};
</script>
