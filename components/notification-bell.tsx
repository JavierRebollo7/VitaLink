// @ts-nocheck
"use client";

import { useState, useEffect } from 'react';
import { Bell, X } from 'lucide-react';
import { format, isWithinInterval, addDays, formatDistanceToNow } from 'date-fns';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Card } from "@/components/ui/card";

interface Event {
  id: string;
  title: string;
  start: Date;
  end: Date;
  description?: string;
}

interface NotificationBellProps {
  events: Event[];
  isMobile?: boolean;
}

export function NotificationBell({ events, isMobile = false }: NotificationBellProps) {
  const [upcomingEvents, setUpcomingEvents] = useState<Event[]>([]);
  const [clearedEvents, setClearedEvents] = useState<Set<string>>(new Set());
  const supabase = createClientComponentClient({  
    options: {
      // @ts-ignore
      persistSession: false,
      cookieOptions: {
        sameSite: 'strict',
      }
    }
  });

  // Fetch cleared notifications on mount
  useEffect(() => {
    const fetchClearedNotifications = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data } = await supabase
        .from('cleared_notifications')
        .select('event_id')
        .eq('user_id', user.id);

      if (data) {
        setClearedEvents(new Set(data.map(item => item.event_id)));
      }
    };

    fetchClearedNotifications();
  }, [supabase]);

  useEffect(() => {
    const now = new Date();
    const weekFromNow = addDays(now, 7);

    const filteredEvents = events
      .filter(event => 
        isWithinInterval(event.start, { start: now, end: weekFromNow }) &&
        !clearedEvents.has(event.id)
      )
      .sort((a, b) => a.start.getTime() - b.start.getTime());

    setUpcomingEvents(filteredEvents);
  }, [events, clearedEvents]);

  const handleClearNotification = async (event: Event) => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    try {
      const { error } = await supabase
        .from('cleared_notifications')
        .insert([{
          user_id: user.id,
          event_id: event.id
        }]);

      if (error) throw error;
      // @ts-ignore
      setClearedEvents(prev => new Set([...prev, event.id]));
    } catch (error) {
      console.error('Error clearing notification:', error);
    }
  };

  return (
    <Popover>
      <PopoverTrigger className="relative">
        <Bell 
          className={`h-5 w-5 ${isMobile ? 'mr-4' : 'mx-2'} hover:text-primary transition-colors`}
        />
        {upcomingEvents.length > 0 && (
          <span className="absolute -top-1 -right-1 h-3 w-3 bg-red-500 rounded-full animate-pulse" />
        )}
      </PopoverTrigger>
      <PopoverContent className="w-80 p-0">
        <Card className="border-none shadow-none">
          <div className="p-4 border-b">
            <h4 className="text-sm font-semibold">Upcoming Events</h4>
          </div>
          <ScrollArea className="h-[300px]">
            {upcomingEvents.length > 0 ? (
              <div className="p-4 space-y-4">
                {upcomingEvents.map((event, index) => (
                  <div 
                    key={index} 
                    className="p-3 rounded-lg bg-gradient-to-r from-primary/10 to-primary/5 hover:from-primary/20 hover:to-primary/10 transition-all relative group"
                  >
                    <button
                      onClick={() => handleClearNotification(event)}
                      className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity"
                      aria-label="Clear notification"
                    >
                      <X className="h-4 w-4 text-muted-foreground hover:text-foreground" />
                    </button>
                    <h5 className="font-medium text-sm pr-6">{event.title}</h5>
                    <p className="text-xs text-muted-foreground mt-1">
                      {format(event.start, 'MMM d, h:mm a')}
                    </p>
                    <p className="text-xs text-primary mt-1">
                      {formatDistanceToNow(event.start, { addSuffix: true })}
                    </p>
                    {event.description && (
                      <p className="text-xs mt-2 text-muted-foreground">
                        {event.description}
                      </p>
                    )}
                  </div>
                ))}
              </div>
            ) : (
              <div className="p-4 text-center text-sm text-muted-foreground">
                No upcoming events in the next 7 days
              </div>
            )}
          </ScrollArea>
        </Card>
      </PopoverContent>
    </Popover>
  );
}