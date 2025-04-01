'use client';

import { createContext, useContext, useState, ReactNode } from 'react';

interface Event {
  title: string;
  start: Date;
  end: Date;
  description?: string;
}

interface EventContextType {
  events: Event[];
  setEvents: (events: Event[]) => void;
}

const EventContext = createContext<EventContextType | undefined>(undefined);

export function EventProvider({ children }: { children: ReactNode }) {
  const [events, setEvents] = useState<Event[]>([]);

  return (
    <EventContext.Provider value={{ events, setEvents }}>
      {children}
    </EventContext.Provider>
  );
}

export function useEvents() {
  const context = useContext(EventContext);
  if (context === undefined) {
    throw new Error('useEvents must be used within an EventProvider');
  }
  return context;
} 