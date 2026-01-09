export interface UserModel {
  id: number;
  full_name: string;
  email: string;
  role: 'student' | 'teacher' | 'admin';
  created_at: string;
  updated_at: string;
  display_name: string;
  is_active: boolean;
  phone_number: string | null;
  photo_url: string | null;
  user_id: number | null;
}
