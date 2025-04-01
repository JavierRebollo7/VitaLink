"use client";

import { useState, useEffect } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';
import { format } from 'date-fns';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { toast } from 'react-hot-toast';

interface AddEventModalProps {
  isOpen: boolean;
  onClose: () => void;
  event?: any;
  slotInfo?: { start: Date; end: Date };
  profiles: any[];
  onSave?: () => void;
  onDelete?: () => void;
  defaultProfileId?: string | null;
}

export default function AddEventModal({
  isOpen,
  onClose,
  event,
  slotInfo,
  profiles,
  onSave,
  onDelete,
  defaultProfileId
}: AddEventModalProps) {
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    profile_id: defaultProfileId || '',
    start: '',
    end: '',
  });
  const supabase = createClientComponentClient();

  useEffect(() => {
    if (event) {
      setFormData({
        title: event.title || '',
        description: event.description || '',
        profile_id: event.profile_id?.toString() || '',
        start: format(event.start, "yyyy-MM-dd'T'HH:mm"),
        end: format(event.end, "yyyy-MM-dd'T'HH:mm"),
      });
    } else if (slotInfo) {
      setFormData({
        ...formData,
        start: format(slotInfo.start, "yyyy-MM-dd'T'HH:mm"),
        end: format(slotInfo.end, "yyyy-MM-dd'T'HH:mm"),
      });
    }
  }, [event, slotInfo]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    // Convert local time to UTC for storage
    const startDate = new Date(formData.start);
    const endDate = new Date(formData.end);

    const eventData = {
      title: formData.title,
      description: formData.description,
      start_time: new Date(startDate.getTime() + startDate.getTimezoneOffset() * 60000).toISOString(),
      end_time: new Date(endDate.getTime() + endDate.getTimezoneOffset() * 60000).toISOString(),
      profile_id: parseInt(formData.profile_id),
      user_id: user.id,
      all_day: false
    };

    if (event) {
      await supabase
        .from('calendar_events')
        .update(eventData)
        .eq('id', event.id);
    } else {
      await supabase
        .from('calendar_events')
        .insert([eventData]);
    }

    onSave?.();
    onClose();
  };

  const handleDelete = async () => {
    if (!event) return;

    try {
      const { error } = await supabase
        .from('calendar_events')
        .delete()
        .eq('id', event.id);

      if (error) throw error;
      
      onDelete?.();
      onClose();
      toast.success('Event deleted successfully');
    } catch (error) {
      console.error('Error deleting event:', error);
      toast.error('Failed to delete event');
      onDelete?.();
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{event ? 'Edit Event' : 'Add New Event'}</DialogTitle>
          <DialogDescription>
            {event 
              ? 'Edit the details of your existing event.' 
              : 'Fill in the details to create a new event.'}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="title">Title</Label>
            <Input
              id="title"
              value={formData.title}
              onChange={(e) => setFormData({ ...formData, title: e.target.value })}
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="profile">Family Member</Label>
            <Select
              value={formData.profile_id}
              onValueChange={(value) => setFormData({ ...formData, profile_id: value })}
            >
              <SelectTrigger>
                <SelectValue placeholder="Select family member" />
              </SelectTrigger>
              <SelectContent>
                {profiles.map((profile) => (
                  <SelectItem key={profile.id} value={profile.id.toString()}>
                    {profile.name} ({profile.family_role})
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="start">Start Time</Label>
              <Input
                id="start"
                type="datetime-local"
                value={formData.start}
                onChange={(e) => setFormData({ ...formData, start: e.target.value })}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="end">End Time</Label>
              <Input
                id="end"
                type="datetime-local"
                value={formData.end}
                onChange={(e) => setFormData({ ...formData, end: e.target.value })}
                required
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="description">Description</Label>
            <Textarea
              id="description"
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              rows={4}
            />
          </div>

          <div className="flex justify-between space-x-2">
            <Button type="button" variant="outline" onClick={onClose}>
              Cancel
            </Button>
            <div className="flex space-x-2">
              {event && (
                <Button type="button" variant="destructive" onClick={handleDelete}>
                  Delete
                </Button>
              )}
              <Button type="submit">
                {event ? 'Update' : 'Create'}
              </Button>
            </div>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
} 