/**
 * Format schedule object to readable string
 * @param schedule - Schedule object with day keys (monday, tuesday, etc.)
 * @returns Formatted schedule string (e.g., "T2: 18:00-19:30, T4: 18:00-19:30")
 */
export const formatScheduleObject = (schedule: any): string => {
  if (typeof schedule === 'string') return schedule;
  if (!schedule || typeof schedule !== 'object') return 'Không có lịch';

  const dayMap: Record<string, string> = {
    monday: 'T2',
    tuesday: 'T3',
    wednesday: 'T4',
    thursday: 'T5',
    friday: 'T6',
    saturday: 'T7',
    sunday: 'CN',
  };

  const scheduleDays = Object.entries(schedule)
    .filter(([_, time]) => time)
    .map(([day, time]) => ({ day: dayMap[day] || day, time }));

  if (scheduleDays.length === 0) return 'Không có lịch';

  // Group by time to avoid duplication
  const timeGroups: Record<string, string[]> = {};
  scheduleDays.forEach(({ day, time }) => {
    const timeStr = time as string;
    if (!timeGroups[timeStr]) timeGroups[timeStr] = [];
    timeGroups[timeStr].push(day);
  });

  return Object.entries(timeGroups)
    .map(([time, days]) => `${days.join(', ')}: ${time}`)
    .join(' | ');
};
