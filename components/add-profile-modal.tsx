"use client";

import { useState, useEffect } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Label } from '@/components/ui/label';
import { Profile } from '@/types/profile';
import { User, Upload } from 'lucide-react';
import { uploadProfileImage } from '@/utils/upload';

interface AddProfileModalProps {
  isOpen: boolean;
  onClose: () => void;
  onAdd: (profile: Omit<Profile, 'id' | 'user_id'>) => void;
  onUpdate?: (id: number, profile: Omit<Profile, 'id' | 'user_id'>) => void;
  editingProfile?: Profile;
  roleType: 'parent' | 'child' | 'other' | null;
}

export default function AddProfileModal({ 
  isOpen, 
  onClose, 
  onAdd, 
  onUpdate, 
  editingProfile,
  roleType 
}: AddProfileModalProps) {
  const [formData, setFormData] = useState({
    name: '',
    date_of_birth: '',
    gender: '',
    blood_type: 'unspecified',
    height: '',
    weight: '',
    family_role: '',
    image_url: '',
  });

  const [imagePreview, setImagePreview] = useState<string | null>(null);

  // Add a state to track if we're showing lbs or kg
  const [weightInLbs, setWeightInLbs] = useState('');

  // Load editing profile data
  useEffect(() => {
    if (editingProfile) {
      setFormData({
        name: editingProfile.name,
        date_of_birth: editingProfile.date_of_birth,
        gender: editingProfile.gender,
        blood_type: editingProfile.blood_type || 'unspecified',
        height: editingProfile.height,
        weight: editingProfile.weight,
        family_role: editingProfile.family_role,
        image_url: editingProfile.image_url || '',
      });
      if (editingProfile.image_url) {
        setImagePreview(editingProfile.image_url);
      }
      setWeightInLbs(kgToLbs(editingProfile.weight));
    } else {
      setFormData(prevData => ({
        ...prevData,
        family_role: '', // Reset family role when not editing
      }));
      setWeightInLbs('');
      setImagePreview(null);
    }
  }, [editingProfile]);

  const handleImageChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      try {
        // Show preview
        const reader = new FileReader();
        reader.onloadend = () => {
          setImagePreview(reader.result as string);
        };
        reader.readAsDataURL(file);

        // Upload to Supabase Storage
        const imageUrl = await uploadProfileImage(file);
        setFormData({ ...formData, image_url: imageUrl });
      } catch (error) {
        console.error('Error handling image:', error);
      }
    }
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingProfile && onUpdate) {
      onUpdate(editingProfile.id, {
        ...formData,
        created_at: editingProfile.created_at,
      });
    } else {
      onAdd({
        ...formData,
        created_at: new Date().toISOString(),
      });
    }
    
    setFormData({
      name: '',
      date_of_birth: '',
      gender: '',
      blood_type: 'unspecified',
      height: '',
      weight: '',
      family_role: '',
      image_url: '',
    });
    setWeightInLbs('');
    setImagePreview(null);
    onClose();
  };

  // Add a weight conversion function at the top of the component
  const lbsToKg = (lbs: string): string => {
    return (Number(lbs) / 2.20462).toFixed(1);
  };

  const kgToLbs = (kg: string): string => {
    return Math.round(Number(kg) * 2.20462).toString();
  };

  const getRoleOptions = () => {
    switch (roleType) {
      case 'parent':
        return ['Father', 'Mother'];
      case 'child':
        return ['Son', 'Daughter'];
      case 'other':
        return ['Grandfather', 'Grandmother', 'Uncle', 'Aunt', 'Cousin', 'Other'];
      default:
        return [];
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-[500px]">
        <DialogHeader>
          <DialogTitle>
            {editingProfile ? 'Edit Profile' : 'Add New Profile'}
          </DialogTitle>
          <DialogDescription>
            {editingProfile 
              ? 'Update the profile information below.' 
              : 'Fill in the profile information below.'}
          </DialogDescription>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Profile Photo */}
          <div className="space-y-2">
            <Label>Profile Photo (Optional)</Label>
            <div className="flex items-center gap-4">
              <div className="w-24 h-24 rounded-full border-2 border-dashed border-muted-foreground/25 flex items-center justify-center overflow-hidden">
                {imagePreview ? (
                  <img src={imagePreview} alt="Preview" className="w-full h-full object-cover" />
                ) : (
                  <User className="w-12 h-12 text-muted-foreground/50" />
                )}
              </div>
              <div>
                <Input
                  type="file"
                  accept="image/*"
                  onChange={handleImageChange}
                  className="hidden"
                  id="profile-photo"
                />
                <Label
                  htmlFor="profile-photo"
                  className="inline-flex items-center gap-2 px-4 py-2 bg-secondary text-secondary-foreground rounded-md cursor-pointer hover:bg-secondary/80"
                >
                  <Upload className="w-4 h-4" />
                  Upload Photo
                </Label>
              </div>
            </div>
          </div>

          {/* Name */}
          <div className="space-y-2">
            <Label htmlFor="name">Full Name</Label>
            <Input
              id="name"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              required
            />
          </div>

          {/* Date of Birth */}
          <div className="space-y-2">
            <Label htmlFor="date_of_birth">Date of Birth</Label>
            <Input
              id="date_of_birth"
              type="date"
              value={formData.date_of_birth}
              onChange={(e) => setFormData({ ...formData, date_of_birth: e.target.value })}
              required
            />
          </div>

          {/* Gender */}
          <div className="space-y-2">
            <Label htmlFor="gender">Gender</Label>
            <Select
              value={formData.gender}
              onValueChange={(value) => setFormData({ ...formData, gender: value })}
              required
            >
              <SelectTrigger>
                <SelectValue placeholder="Select gender" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="male">Male</SelectItem>
                <SelectItem value="female">Female</SelectItem>
                <SelectItem value="other">Other</SelectItem>
              </SelectContent>
            </Select>
          </div>

          {/* Family Role */}
          <div className="space-y-2">
            <Label htmlFor="family_role">Family Role</Label>
            <Select
              value={formData.family_role}
              onValueChange={(value) => setFormData({ ...formData, family_role: value })}
              required
            >
              <SelectTrigger>
                <SelectValue placeholder="Select role" />
              </SelectTrigger>
              <SelectContent>
                {getRoleOptions().map((role) => (
                  <SelectItem key={role.toLowerCase()} value={role.toLowerCase()}>
                    {role}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {/* Height */}
          <div className="space-y-2">
            <Label htmlFor="height">Height (cm)</Label>
            <Input
              id="height"
              type="number"
              min="0"
              max="300"
              value={formData.height}
              onChange={(e) => setFormData({ ...formData, height: e.target.value })}
              required
            />
          </div>

          {/* Weight */}
          <div className="space-y-2">
            <Label htmlFor="weight">Weight (lbs)</Label>
            <Input
              id="weight"
              type="number"
              min="0"
              max="1000"
              step="1"
              value={editingProfile ? kgToLbs(formData.weight) : weightInLbs}
              onChange={(e) => {
                const value = e.target.value;
                setWeightInLbs(value);
                setFormData({ ...formData, weight: lbsToKg(value) });
              }}
              required
            />
          </div>

          {/* Blood Type */}
          <div className="space-y-2">
            <Label htmlFor="blood_type">Blood Type (Optional)</Label>
            <Select
              value={formData.blood_type}
              onValueChange={(value) => setFormData({ ...formData, blood_type: value })}
            >
              <SelectTrigger>
                <SelectValue placeholder="Select blood type" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="unspecified">Unspecified</SelectItem>
                {['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((type) => (
                  <SelectItem key={type} value={type}>
                    {type}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="flex justify-end space-x-2 pt-4">
            <Button variant="outline" onClick={onClose} type="button">
              Cancel
            </Button>
            <Button type="submit">
              {editingProfile ? 'Update Profile' : 'Add Profile'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
} 