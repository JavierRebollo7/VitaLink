import './globals.css';
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import { Toaster } from '@/components/ui/toaster';
import Navigation from '@/components/navigation';
import Footer from '@/components/footer';
import { EventProvider } from '../app/contexts/EventContext';
import { Toaster as HotToaster } from 'react-hot-toast';
import { ToastProvider } from '@/components/ui/toast';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'VitaLink',
  description: 'Your medical document management system',
  icons: {
    icon: '/favicon.svg',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <meta 
          name="viewport" 
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" 
        />
      </head>
      <body className={inter.className}>
        <ToastProvider>
          <EventProvider>
            <Navigation />
            {children}
            <Footer />
          </EventProvider>
          <Toaster />
          <HotToaster position="bottom-right" />
        </ToastProvider>
      </body>
    </html>
  );
}