// @ts-nocheck
"use client";

import { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Plus } from 'lucide-react';
import ChatWindow from '@/components/chat-window';
import UserProfileCard from '@/components/user-profile-card';
import AddProfileModal from '@/components/add-profile-modal';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { Profile } from '@/types/profile';
import ViewportMeta from '@/components/viewport-meta';

export default function DashboardPage() {
  const [profiles, setProfiles] = useState<Profile[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [editingProfile, setEditingProfile] = useState<Profile | undefined>();
  const [roleType, setRoleType] = useState<'parent' | 'child' | 'other' | null>(null);
  const supabase = createClientComponentClient();

  useEffect(() => {
    fetchProfiles();
  }, []);

  const fetchProfiles = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: true });

      if (error) throw error;
      setProfiles(data || []);
    } catch (error) {
      console.error('Error fetching profiles:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleAddProfile = async (newProfile: Omit<Profile, 'id' | 'user_id'>) => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data, error } = await supabase
        .from('profiles')
        .insert([{ ...newProfile, user_id: user.id }])
        .select()
        .single();

      if (error) throw error;
      if (data) {
        setProfiles([...profiles, data]);
      }
      setIsModalOpen(false);
    } catch (error) {
      console.error('Error adding profile:', error);
    }
  };

  const handleUpdateProfile = async (id: number, updatedProfile: Omit<Profile, 'id' | 'user_id'>) => {
    try {
      console.log('Updating profile with data:', { id, updatedProfile });
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      // First, check if the profile exists and belongs to the user
      const { data: existingProfile, error: fetchError } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', id)
        .eq('user_id', user.id)
        .single();

      if (fetchError) {
        console.error('Error fetching existing profile:', fetchError);
        throw fetchError;
      }

      if (!existingProfile) {
        throw new Error('Profile not found or unauthorized');
      }

      // Then perform the update
      const { data, error } = await supabase
        .from('profiles')
        .update({
          name: updatedProfile.name,
          date_of_birth: updatedProfile.date_of_birth,
          gender: updatedProfile.gender,
          blood_type: updatedProfile.blood_type,
          height: updatedProfile.height,
          weight: updatedProfile.weight,
          family_role: updatedProfile.family_role,
          image_url: updatedProfile.image_url,
        })
        .eq('id', id)
        .eq('user_id', user.id)
        .select()
        .single();

      if (error) {
        console.error('Supabase update error:', {
          message: error.message,
          details: error.details,
          hint: error.hint,
          code: error.code
        });
        throw error;
      }
      
      if (data) {
        setProfiles(profiles.map(p => p.id === id ? data : p));
        setIsModalOpen(false);
        setEditingProfile(undefined);
      }
    } catch (error) {
      if (error instanceof Error) {
        console.error('Error updating profile:', {
          message: error.message,
          stack: error.stack
        });
      } else {
        console.error('Unknown error updating profile:', error);
      }
      throw error;
    }
  };

  const handleEditClick = (profile: Profile) => {
    // Determine roleType based on the profile's family role
    let editRoleType: 'parent' | 'child' | 'other';
    if (['father', 'mother'].includes(profile.family_role.toLowerCase())) {
      editRoleType = 'parent';
    } else if (['son', 'daughter'].includes(profile.family_role.toLowerCase())) {
      editRoleType = 'child';
    } else {
      editRoleType = 'other';
    }
    
    setRoleType(editRoleType);
    setEditingProfile(profile);
    setIsModalOpen(true);
  };

  const handleAddProfileClick = (roleType: 'parent' | 'child' | 'other') => {
    setRoleType(roleType);
    setIsModalOpen(true);
  };

  // New function to filter profiles by role type
  const filterProfilesByRole = (roles: string[]) => {
    return profiles.filter(profile => roles.includes(profile.family_role.toLowerCase()));
  };

  // Get profiles for each section
  const parentProfiles = filterProfilesByRole(['father', 'mother']);
  const childrenProfiles = filterProfilesByRole(['son', 'daughter']);
  const otherProfiles = filterProfilesByRole([
    'grandfather', 'grandmother', 'uncle', 'aunt', 'cousin', 'other'
  ]);

  return (
    <>
      <ViewportMeta />
      <main className="min-h-screen bg-background pt-20">
        <div className="container mx-auto px-4 py-8">
          {/* AI Chat Section */}
          <section className="mb-12">
            <h2 className="text-2xl font-bold mb-6 bg-gradient-to-r from-primary to-primary/60 text-primary-foreground px-4 py-2 rounded-lg inline-block">
              Medical Assistant
            </h2>
            <ChatWindow />
          </section>

          {/* User Profiles Section */}
          <section className="mb-24">
            <h2 className="text-2xl font-bold mb-8 bg-gradient-to-r from-primary to-primary/60 text-primary-foreground px-4 py-2 rounded-lg inline-block">
              Family Profiles
            </h2>

            {/* Parents Subsection */}
            <div className="mb-12">
              <h3 className="text-lg font-medium mb-4 text-foreground/80">Parents</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {parentProfiles.map((profile) => (
                  <UserProfileCard 
                    key={profile.id} 
                    profile={profile}
                    onEdit={handleEditClick}
                    onDelete={async (id) => {
                      await supabase.from('profiles').delete().eq('id', id);
                      // @ts-ignore
                      setProfiles(profiles.filter(p => p.id !== id));
                    }}
                  />
                ))}
                <Card 
                  className="flex flex-col items-center justify-center p-6 hover:bg-accent/50 cursor-pointer transition-colors border-dashed"
                  onClick={() => handleAddProfileClick('parent')}
                >
                  <Plus className="h-12 w-12 text-muted-foreground mb-4" />
                  <p className="text-lg font-medium text-muted-foreground">Add Parent</p>
                </Card>
              </div>
            </div>

            {/* Children Subsection */}
            <div className="mb-12">
              <h3 className="text-lg font-medium mb-4 text-foreground/80">Children</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {childrenProfiles.map((profile) => (
                  <UserProfileCard 
                    key={profile.id} 
                    profile={profile}
                    onEdit={handleEditClick}
                    onDelete={async (id) => {
                      await supabase.from('profiles').delete().eq('id', id);
                      // @ts-ignore
                      setProfiles(profiles.filter(p => p.id !== id));
                    }}
                  />
                ))}
                <Card 
                  className="flex flex-col items-center justify-center p-6 hover:bg-accent/50 cursor-pointer transition-colors border-dashed"
                  onClick={() => handleAddProfileClick('child')}
                >
                  <Plus className="h-12 w-12 text-muted-foreground mb-4" />
                  <p className="text-lg font-medium text-muted-foreground">Add Child</p>
                </Card>
              </div>
            </div>

            {/* Other Family Subsection */}
            <div className="mb-12">
              <h3 className="text-lg font-medium mb-4 text-foreground/80">Other Family</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {otherProfiles.map((profile) => (
                  <UserProfileCard 
                    key={profile.id} 
                    profile={profile}
                    onEdit={handleEditClick}
                    onDelete={async (id) => {
                      await supabase.from('profiles').delete().eq('id', id);
                      // @ts-ignore
                      setProfiles(profiles.filter(p => p.id !== id));
                    }}
                  />
                ))}
                <Card 
                  className="flex flex-col items-center justify-center p-6 hover:bg-accent/50 cursor-pointer transition-colors border-dashed"
                  onClick={() => handleAddProfileClick('other')}
                >
                  <Plus className="h-12 w-12 text-muted-foreground mb-4" />
                  <p className="text-lg font-medium text-muted-foreground">Add Family Member</p>
                </Card>
              </div>
            </div>
          </section>
        </div>

        <AddProfileModal 
          isOpen={isModalOpen} 
          onClose={() => {
            setIsModalOpen(false);
            setRoleType(null);
          }}
          onAdd={handleAddProfile}
          onUpdate={handleUpdateProfile}
          editingProfile={editingProfile}
          roleType={roleType}
        />
      </main>
    </>
  );
} 