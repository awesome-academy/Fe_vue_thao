<template>
  <div class="space-y-6">
    <StudentClassesManager
      :classes="myClasses"
      :available-classes="availableClasses?.classes || []"
      :error="error"
      :pending="pending"
      :refresh="refresh"
      :refresh-student-classes="refreshStudentClasses"
      v-model:search-query="searchQuery"
      v-model:subject="subject"
      v-model:available-page="availablePage"
      v-model:available-per-page="availablePerPage"
      :subjects="Array.isArray(subjects) ? subjects : subjects?.subjects || []"
      :subjects-pending="subjectsPending"
      :available-total-pages="availableTotalPages"
      :available-total-items="availableTotalItems"
      :my-classes-page="myClassesPage"
      :my-classes-per-page="myClassesPerPage"
      :my-classes-total-pages="myClassesTotalPages"
      :my-classes-total-items="myClassesTotalItems"
      @update:my-classes-page="myClassesPage = $event"
      @update:my-classes-per-page="
        myClassesPerPage = $event;
        myClassesPage = 1;
      "
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
definePageMeta({
  layout: 'student',
});

const searchQuery = ref('');
const availablePage = ref(1);
const availablePerPage = ref(20);
const myClassesPage = ref(1);
const myClassesPerPage = ref(10);
const classApi = useClassApi();
const subject = ref(undefined);

const {
  data: availableClasses,
  error,
  pending,
  refresh,
} = await useAsyncData(
  'availableClasses',
  async () => {
    const response = await classApi.fetchClasses({
      page: availablePage.value,
      perPage: availablePerPage.value,
      search: searchQuery.value,
      subject: subject.value,
    });
    return response.data;
  },
  {
    default: () => ({
      classes: [],
      pagination: {
        current_page: 1,
        per_page: 20,
        total_count: 0,
        total_pages: 0,
      },
    }),
    watch: [availablePage, availablePerPage, searchQuery, subject],
  }
);

const { data: subjects, pending: subjectsPending } = await useAsyncData(
  'subjects',
  async () => {
    const response = await classApi.fetchSubjects();
    console.log(response.data);
    return response.data;
  },
  {
    default: () => ({ subjects: [] }),
  }
);

// Fetch student's enrolled classes
const {
  data: studentClassesData,
  pending: studentClassesPending,
  error: studentClassesError,
  refresh: refreshStudentClasses,
} = await useAsyncData(
  'studentClasses',
  async () => {
    const response = await classApi.fetchStudentClasses({
      page: myClassesPage.value,
      per_page: myClassesPerPage.value,
    });
    return response.data;
  },

  {
    default: () => ({
      classes: [],
      pagination: {
        current_page: 1,
        per_page: 20,
        total_count: 0,
        total_pages: 0,
      },
    }),
    watch: [myClassesPage, myClassesPerPage],
  }
);

const myClasses = computed(() => {
  return (
    studentClassesData.value?.classes?.map((cls: any) => ({
      id: cls.class_id.toString(),
      code: cls.class_id.toString(),
      name: cls.class_name,
      teacher: cls.teacher_name,
      schedule: formatScheduleObject(cls.schedule),
      room: 'N/A',
      attended: cls.sessions_attended,
      totalSessions: Object.keys(cls.schedule).length * 4,
      status: cls.status,
      class_id: cls.class_id,
    })) || []
  );
});

// Computed properties for available classes pagination
const availableTotalPages = computed(
  () => availableClasses.value?.pagination?.total_pages || 1
);

const availableTotalItems = computed(
  () => availableClasses.value?.pagination?.total_count || 0
);

// Computed properties for my classes pagination
const myClassesTotalPages = computed(
  () => studentClassesData.value?.pagination?.total_pages || 1
);

const myClassesTotalItems = computed(
  () => studentClassesData.value?.pagination?.total_count || 0
);
</script>
