export interface Profile {
  id: number;
  user_id: string;
  name: string;
  date_of_birth: string;
  gender: string;
  height: string;
  weight: string;
  blood_type?: string;
  family_role: string;
  allergies?: string[];
  medical_conditions?: string[];
  medications?: string[];
  image_url?: string;
  created_at: string;
} 