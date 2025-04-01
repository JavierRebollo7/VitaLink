"use client";

import { useState, useEffect, useCallback, useMemo, useRef } from 'react';
import { Calendar, dateFnsLocalizer, Views } from 'react-big-calendar';
import withDragAndDrop from "react-big-calendar/lib/addons/dragAndDrop";
import { format } from 'date-fns/format';
import { parse } from 'date-fns/parse';
import { startOfWeek } from 'date-fns/startOfWeek';
import { getDay } from 'date-fns/getDay';
import { enUS } from 'date-fns/locale';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { Card } from '@/components/ui/card';
import ViewportMeta from '@/components/viewport-meta';
import { useSearchParams } from 'next/navigation';
import { useTheme } from 'next-themes';
import 'react-big-calendar/lib/css/react-big-calendar.css';
import "react-big-calendar/lib/addons/dragAndDrop/styles.css";
import './calendar-global.css';
import AddEventModal from '@/components/add-event-modal';
import { toast } from 'sonner';
import styles from './calendar.module.css';
import { useMediaQuery } from '../../hooks/useMediaQuery';
import { useEvents } from '../../contexts/EventContext';

interface Profile {
  id: string;
  name: string;
  user_id: string;
}

interface CalendarEvent {
  id: string;
  title: string;
  start: Date;
  end: Date;
  profile_id: string;
  description?: string;
  allDay: boolean;
}

interface SlotInfo {
  start: Date;
  end: Date;
}

interface EventDropProps {
  event: CalendarEvent;
  start: Date;
  end: Date;
}

interface EventResizeProps {
  event: CalendarEvent;
  start: Date;
  end: Date;
}

interface ToolbarProps {
  date: Date;
  view: typeof Views[keyof typeof Views];
  label: string;
  onView: (view: typeof Views[keyof typeof Views]) => void;
  onNavigate: (action: 'TODAY' | 'PREV' | 'NEXT') => void;
}

interface EventInteractionArgs<T> {
  event: T;
  start: Date;
  end: Date;
}

const locales = {
  'en-US': require('date-fns/locale/en-US'),
};

const localizer = dateFnsLocalizer({
  format,
  parse,
  startOfWeek,
  getDay,
  locales,
});

const DnDCalendar = withDragAndDrop(Calendar);

export default function CalendarPage() {
  const { theme } = useTheme();
  const [events, setEvents] = useState<CalendarEvent[]>([]);
  const [profiles, setProfiles] = useState<Profile[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedEvent, setSelectedEvent] = useState<CalendarEvent | null>(null);
  const [selectedSlot, setSelectedSlot] = useState<SlotInfo | null>(null);
  const supabase = createClientComponentClient();
  const searchParams = useSearchParams();
  const profileId = searchParams.get('profile');
  const { setEvents: setContextEvents } = useEvents();
  const action = searchParams.get('action');
  const [mounted, setMounted] = useState(false);
  const isMobile = useMediaQuery('(max-width: 768px)');
  const [view, setView] = useState<typeof Views[keyof typeof Views]>('month');
  const [date, setDate] = useState(new Date());

  const fetchProfiles = useCallback(async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const { data } = await supabase
      .from('profiles')
      .select('*')
      .eq('user_id', user.id);

    setProfiles(data || []);
  }, [supabase]);

  const fetchEvents = useCallback(async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const query = supabase
      .from('calendar_events')
      .select('*')
      .eq('user_id', user.id);

    if (profileId) {
      query.eq('profile_id', profileId);
    }

    const { data } = await query;
    
    const formattedEvents = (data?.map(event => {
      const start = new Date(event.start_time);
      const end = new Date(event.end_time);
      
      if (isNaN(start.getTime()) || isNaN(end.getTime())) {
        console.error('Invalid date found:', event);
        return null;
      }

      return {
        id: event.id,
        title: event.title,
        start: new Date(start.getTime() - start.getTimezoneOffset() * 60000),
        end: new Date(end.getTime() - end.getTimezoneOffset() * 60000),
        profile_id: event.profile_id,
        description: event.description,
        allDay: false
      } as CalendarEvent;
    }).filter((event): event is CalendarEvent => event !== null) || []) as CalendarEvent[];

    setEvents(formattedEvents);
    setContextEvents(formattedEvents);
  }, [supabase, profileId, setContextEvents]);

  useEffect(() => {
    fetchProfiles();
    fetchEvents();
  }, [fetchProfiles, fetchEvents]);

  useEffect(() => {
    if (action === 'schedule') {
      const now = new Date();
      const endTime = new Date(now.getTime() + 60 * 60 * 1000); // 1 hour later
      setSelectedSlot({ start: now, end: endTime });
      setIsModalOpen(true);
    }
  }, [action]);

  useEffect(() => {
    setMounted(true);
  }, []);

  const handleSelectSlot = useCallback(({ start, end }: SlotInfo) => {
    setSelectedSlot({ start, end });
    setIsModalOpen(true);
  }, []);

  const handleSelectEvent = useCallback((event: object, e: React.SyntheticEvent<HTMLElement, Event>) => {
    setSelectedEvent(event as CalendarEvent);
    setIsModalOpen(true);
  }, []);

  const eventStyleGetter = useCallback(
    (event: CalendarEvent) => ({
      style: {
        backgroundColor: theme === 'dark' ? '#3b82f6' : '#60a5fa',
        color: '#ffffff',
      },
    }),
    [theme]
  );

  const handleSave = async () => {
    try {
      await fetchEvents();
      setIsModalOpen(false);
      setSelectedEvent(null);
      setSelectedSlot(null);
      
      if (action === 'schedule') {
        const newUrl = new URL(window.location.href);
        newUrl.searchParams.delete('action');
        window.history.replaceState({}, '', newUrl.toString());
        window.location.reload();
      }
      
      toast.success('Event saved successfully');
    } catch (error) {
      console.error('Error saving event:', error);
      toast.error('Failed to save event');
    }
  };

  const handleDelete = async () => {
    try {
      await fetchEvents();
      setIsModalOpen(false);
      setSelectedEvent(null);
      setSelectedSlot(null);
      toast.success('Event deleted successfully');
    } catch (error) {
      console.error('Error deleting event:', error);
      toast.error('Failed to delete event');
      fetchEvents();
    }
  };

  const moveEvent = useCallback(async ({ event, start, end }: EventDropProps) => {
    try {
      setEvents(prevEvents => 
        prevEvents.map(e => 
          e.id === event.id 
            ? { ...e, start, end }
            : e
        )
      );

      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { error } = await supabase
        .from('calendar_events')
        .update({
          start_time: format(start, "yyyy-MM-dd'T'HH:mm:ss.SSS"),
          end_time: format(end, "yyyy-MM-dd'T'HH:mm:ss.SSS"),
        })
        .eq('id', event.id);

      if (error) throw error;
      toast.success('Event moved successfully');
    } catch (error) {
      console.error('Error moving event:', error);
      toast.error('Failed to move event');
      setEvents(prevEvents => 
        prevEvents.map(e => 
          e.id === event.id 
            ? { ...e, start: event.start, end: event.end }
            : e
        )
      );
    }
  }, [supabase]);

  const resizeEvent = useCallback(async ({ event, start, end }: EventResizeProps) => {
    try {
      setEvents(prevEvents => 
        prevEvents.map(e => 
          e.id === event.id 
            ? { ...e, start, end }
            : e
        )
      );

      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { error } = await supabase
        .from('calendar_events')
        .update({
          start_time: format(start, "yyyy-MM-dd'T'HH:mm:ss.SSS"),
          end_time: format(end, "yyyy-MM-dd'T'HH:mm:ss.SSS"),
        })
        .eq('id', event.id);

      if (error) throw error;
      toast.success('Event resized successfully');
    } catch (error) {
      console.error('Error resizing event:', error);
      toast.error('Failed to resize event');
      setEvents(prevEvents => 
        prevEvents.map(e => 
          e.id === event.id 
            ? { ...e, start: event.start, end: event.end }
            : e
        )
      );
    }
  }, [supabase]);

  // Define available views based on screen size
  const views = useMemo(() => {
    return isMobile ? {
      day: true,
      month: true
    } : {
      month: true,
      week: true,
      day: true
    };
  }, [isMobile]);

  // Define default view based on screen size
  const defaultView = useMemo(() => {
    return isMobile ? 'day' : 'month';
  }, [isMobile]);

  // Handle view change
  const handleViewChange = useCallback((newView: typeof Views[keyof typeof Views]) => {
    setView(newView);
  }, []);

  // Handle date change
  const handleNavigate = useCallback((newDate: Date) => {
    setDate(newDate);
  }, []);

  // Custom toolbar component
  const CustomToolbar = useCallback(({ date, view, label, onView, onNavigate }: ToolbarProps) => {
    const goToToday = () => {
      onNavigate('TODAY');
    };
    
    const goToPrev = () => {
      onNavigate('PREV');
    };
    
    const goToNext = () => {
      onNavigate('NEXT');
    };
    
    return (
      <div className="rbc-toolbar">
        <span className="rbc-btn-group">
          <button type="button" onClick={goToToday}>Today</button>
          <button type="button" onClick={goToPrev}>Back</button>
          <button type="button" onClick={goToNext}>Next</button>
        </span>
        <span className="rbc-toolbar-label">{label}</span>
        <span className="rbc-btn-group">
          <button 
            type="button" 
            className={view === 'month' ? 'rbc-active' : ''}
            onClick={() => onView('month')}
          >
            Month
          </button>
          <button 
            type="button" 
            className={view === 'week' ? 'rbc-active' : ''}
            onClick={() => onView('week')}
          >
            Week
          </button>
          <button 
            type="button" 
            className={view === 'day' ? 'rbc-active' : ''}
            onClick={() => onView('day')}
          >
            Day
          </button>
        </span>
      </div>
    );
  }, []);

  return (
    <>
      <ViewportMeta />
      <main className="min-h-screen bg-background pt-20">
        <div className="container mx-auto px-4 py-8">
          <div className="flex flex-col space-y-8">
            <h1 className="text-2xl font-bold bg-gradient-to-r from-primary to-primary/60 text-primary-foreground px-4 py-2 rounded-lg inline-block w-fit">
              Calendar
            </h1>
            
            {mounted ? (
              <Card className="p-2 sm:p-4">
                <div className="h-[calc(100vh-300px)] min-h-[400px] sm:h-[700px]">
                  <DnDCalendar
                    localizer={localizer}
                    events={events}
                    startAccessor={(event: object) => (event as CalendarEvent).start}
                    endAccessor={(event: object) => (event as CalendarEvent).end}
                    onSelectSlot={handleSelectSlot}
                    onSelectEvent={handleSelectEvent}
                    onEventDrop={moveEvent as any}
                    onEventResize={resizeEvent as any}
                    resizable
                    selectable
                    date={date}
                    view={view}
                    onView={handleViewChange}
                    onNavigate={handleNavigate}
                    defaultView="month"
                    step={30}
                    timeslots={2}
                    min={new Date(0, 0, 0, 0, 0, 0)}
                    max={new Date(0, 0, 0, 23, 59, 59)}
                    style={{ height: "100%" }}
                    className={styles.calendar}
                    views={views}
                    components={{
                      toolbar: CustomToolbar
                    }}
                    eventPropGetter={eventStyleGetter as any}
                  />
                </div>
              </Card>
            ) : (
              <div className="flex items-center justify-center h-[600px]">
                <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary"></div>
              </div>
            )}
          </div>
        </div>

        {isModalOpen && (
          <AddEventModal 
            isOpen={isModalOpen}
            onClose={() => {
              setIsModalOpen(false);
              setSelectedEvent(null);
              setSelectedSlot(null);
            }}
            event={selectedEvent}
            slotInfo={selectedSlot || undefined}
            profiles={profiles}
            onSave={handleSave}
            onDelete={handleDelete}
            defaultProfileId={profileId}
          />
        )}
      </main>
    </>
  );
} 