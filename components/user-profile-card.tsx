// @ts-nocheck
"use client";

import { Card, CardContent, CardHeader } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Edit, Trash2, User, Ruler, Weight, Droplets, Calendar, UserCircle, FileSearch, FileText, MoreVertical, Pencil, Trash } from 'lucide-react';
import Image from 'next/image';
import { Profile } from '@/types/profile';
import { useRouter } from 'next/navigation';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';

interface UserProfileCardProps {
  profile: Profile;
  onDelete?: (id: string) => void;
  onEdit?: (profile: Profile) => void;
}

export default function UserProfileCard({ profile, onDelete, onEdit }: UserProfileCardProps) {
  const router = useRouter();
  const supabase = createClientComponentClient();

  const calculateAge = (birthDate: string) => {
    const birth = new Date(birthDate);
    const today = new Date();
    let age = today.getFullYear() - birth.getFullYear();
    const monthDiff = today.getMonth() - birth.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
      age--;
    }
    return age.toString();
  };

  const handleRelatedFiles = () => {
    router.push(`/dashboard/files?profile=${profile.id}`);
  };

  const handleScheduleClick = async () => {
    try {
      if (!profile.id) {
        console.error('Invalid profile ID');
        return;
      }

      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      // Skip the events query since it's causing type mismatch issues
      // We'll handle the events fetching in the calendar page instead
      router.push(`/dashboard/calendar?profile=${profile.id}`);
    } catch (error) {
      console.error('Error handling schedule click:', error);
    }
  };

  return (
    <Card className="overflow-hidden group hover:shadow-xl transition-all duration-300 relative bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800 border-2">
      <div className="absolute inset-0 bg-gradient-to-br from-white/50 to-transparent dark:from-black/50 pointer-events-none" />
      
      <CardHeader className="relative p-0">
        <div className="absolute right-2 top-2 flex gap-1 z-10 opacity-0 group-hover:opacity-100 transition-opacity">
          <Button variant="secondary" size="icon" onClick={() => onEdit?.(profile)} className="h-8 w-8 bg-white/80 hover:bg-white dark:bg-gray-800/80 dark:hover:bg-gray-800">
            <Edit className="h-4 w-4" />
          </Button>
          {onDelete && (
            <Button 
              variant="ghost"
              size="icon"
              className="h-8 w-8 bg-white/80 hover:bg-red-500 hover:text-white dark:bg-gray-800/80"
              // @ts-ignore
              onClick={() => onDelete(profile.id)}
            >
              <Trash className="h-4 w-4" />
            </Button>
          )}
        </div>
      </CardHeader>

      <CardContent className="relative p-6">
        <div className="flex flex-col items-center">
          <div className="w-24 h-24 rounded-full overflow-hidden mb-4">
            {profile.image_url ? (
              <img
                src={profile.image_url}
                alt={profile.name}
                className="w-full h-full object-cover"
                style={{ imageRendering: 'crisp-edges' }}
                loading="lazy"
              />
            ) : (
              <div className="w-full h-full bg-secondary flex items-center justify-center">
                <User className="w-12 h-12 text-muted-foreground" />
              </div>
            )}
          </div>
          <h3 className="text-xl font-semibold mb-1">{profile.name}</h3>
          <span className="px-3 py-1 bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-300 rounded-full text-sm mb-4 font-medium">
            {profile.family_role.charAt(0).toUpperCase() + profile.family_role.slice(1)}
          </span>
          
          <div className="w-full grid grid-cols-2 gap-3 mt-2">
            {[
              { icon: Calendar, label: 'Age', value: calculateAge(profile.date_of_birth) },
              { icon: UserCircle, label: 'Gender', value: profile.gender, capitalize: true },
              { icon: Ruler, label: 'Height', value: `${profile.height} cm` },
              { icon: Weight, label: 'Weight', value: `${Math.round(Number(profile.weight) * 2.20462)} lbs` },
            ].map((stat, index) => (
              <div key={stat.label} 
                className="flex items-center gap-2 bg-white/50 dark:bg-gray-800/50 p-2.5 rounded-xl backdrop-blur-sm transition-transform hover:scale-105">
                <stat.icon className="h-4 w-4 text-gray-500 dark:text-gray-400" />
                <div className="flex flex-col">
                  <span className="text-xs text-gray-500 dark:text-gray-400 font-medium">{stat.label}</span>
                  <span className={`text-sm font-semibold text-gray-700 dark:text-gray-200 ${stat.capitalize ? 'capitalize' : ''}`}>
                    {stat.value}
                  </span>
                </div>
              </div>
            ))}
          </div>
          
          <div className="mt-4 flex items-center gap-2 justify-center flex-wrap">
            {profile.blood_type && profile.blood_type !== 'unspecified' ? (
              <>
                <div className="flex items-center gap-2 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 px-4 py-2 rounded-full text-sm font-medium">
                  <Droplets className="h-4 w-4" />
                  {profile.blood_type}
                </div>
                <button
                  onClick={handleScheduleClick}
                  className="flex items-center gap-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 px-4 py-2 rounded-full text-sm font-medium hover:bg-blue-100 dark:hover:bg-blue-900/30 transition-colors whitespace-nowrap"
                >
                  <Calendar className="h-4 w-4" />
                  Schedule
                </button>
                <button
                  onClick={handleRelatedFiles}
                  className="flex items-center gap-2 bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 px-4 py-2 rounded-full text-sm font-medium hover:bg-green-100 dark:hover:bg-green-900/30 transition-colors whitespace-nowrap"
                >
                  <FileText className="h-4 w-4" />
                  Files
                </button>
              </>
            ) : (
              <div className="flex items-center gap-2 w-full justify-center">
                <button
                  onClick={handleScheduleClick}
                  className="flex items-center gap-2 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 px-4 py-2 rounded-full text-sm font-medium hover:bg-blue-100 dark:hover:bg-blue-900/30 transition-colors whitespace-nowrap"
                >
                  <Calendar className="h-4 w-4" />
                  Schedule
                </button>
                <button
                  onClick={handleRelatedFiles}
                  className="flex items-center gap-2 bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 px-4 py-2 rounded-full text-sm font-medium hover:bg-green-100 dark:hover:bg-green-900/30 transition-colors whitespace-nowrap"
                >
                  <FileText className="h-4 w-4" />
                  Files
                </button>
              </div>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  );
} 