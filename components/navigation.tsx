// @ts-nocheck
"use client";

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Menu, Heart, User } from 'lucide-react';
import { NotificationBell } from './notification-bell';
import { useEvents } from '../app/contexts/EventContext';
import {
  Sheet,
  SheetContent,
  SheetTrigger,
  SheetHeader,
  SheetTitle,
  SheetDescription,
} from '@/components/ui/sheet';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { useRouter, usePathname } from 'next/navigation';

export default function Navigation() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [user, setUser] = useState<any>(null);
  const supabase = createClientComponentClient({  
    options: {
      // @ts-ignore
      persistSession: false,
      cookieOptions: {
        sameSite: 'strict',
      }
    }
  });
  const router = useRouter();
  const pathname = usePathname();
  const isLandingPage = pathname === '/';
  const isDashboard = pathname?.startsWith('/dashboard');
  const { events } = useEvents();
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 10);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  useEffect(() => {
    const getUser = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      setUser(user);
    };
    
    getUser();

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user);
    });

    return () => subscription.unsubscribe();
  }, [supabase.auth]);

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    router.refresh();
  };

  const scrollToSection = (elementId: string) => {
    const element = document.getElementById(elementId);
    if (element) {
      const offset = 80;
      const elementPosition = element.getBoundingClientRect().top;
      const offsetPosition = elementPosition + window.pageYOffset - offset;

      window.scrollTo({
        top: offsetPosition,
        behavior: 'smooth'
      });
    }
  };

  const publicLinks = [
    { id: 'features', label: 'Features' },
    { id: 'pricing', label: 'Pricing' },
  ];

  const dashboardLinks = [
    { href: '/dashboard', label: 'Dashboard' },
    { href: '/dashboard/files', label: 'Files' },
    { href: '/dashboard/calendar', label: 'Calendar' },
    { href: '/dashboard/map', label: 'Map' },
  ];

  const handleLinkClick = (callback?: () => void) => {
    setIsOpen(false);  // Close the sheet
    if (callback) callback();
  };

  return (
    <nav
      className={`fixed top-0 left-0 right-0 z-50 border-b bg-background/80 backdrop-blur-sm ${
        isScrolled ? 'shadow-sm' : ''
      }`}
    >
      <div className="container mx-auto">
        <div className="flex h-16 items-center justify-between">
          <div className="flex items-center space-x-8">
            <div className="flex items-center space-x-8">
              <Link href="/" className="flex items-center space-x-2 md:pl-0 pl-4">
                <Heart className="h-6 w-6 text-primary" />
                <span className="font-bold text-xl">VitaLink</span>
              </Link>
              {isLandingPage && user && (
                <div className="hidden md:block">
                  <Link
                    href="/dashboard"
                    className="text-foreground/80 hover:text-foreground transition-colors"
                  >
                    Dashboard
                  </Link>
                </div>
              )}
            </div>

            {isLandingPage && (
              <div className="hidden md:flex items-center space-x-6">
                {publicLinks.map((link) => (
                  <button
                    key={link.id}
                    onClick={() => scrollToSection(link.id)}
                    className="text-foreground/80 hover:text-foreground transition-colors"
                  >
                    {link.label}
                  </button>
                ))}
              </div>
            )}

            {user && isDashboard && (
              <div className="hidden md:flex items-center space-x-6">
                {dashboardLinks.map((link) => (
                  <Link
                    key={link.href}
                    href={link.href}
                    className={`relative text-foreground/80 hover:text-foreground transition-colors py-1
                      after:absolute after:left-0 after:bottom-0 after:h-0.5 after:w-full 
                      after:origin-center after:scale-x-0 after:bg-primary after:transition-transform after:duration-200
                      hover:after:scale-x-100
                      ${pathname === link.href ? 'text-foreground font-medium after:scale-x-100' : ''}`}
                  >
                    {link.label}
                  </Link>
                ))}
              </div>
            )}
          </div>

          <div className="hidden md:flex md:items-center md:gap-4">
            {user ? (
              <>
                <div className="flex items-center space-x-2">
                  <User className="h-4 w-4" />
                  <span className="text-sm text-muted-foreground">
                    {user.email}
                  </span>
                </div>
                <NotificationBell 
                  // @ts-ignore
                  events={events} 
                />
                <Button variant="ghost" onClick={handleSignOut}>
                  Sign out
                </Button>
              </>
            ) : (
              <>
                <Link href="/login">
                  <Button variant="ghost">Sign in</Button>
                </Link>
                <Link href="/signup">
                  <Button>Sign up</Button>
                </Link>
              </>
            )}
          </div>

          <div className="flex items-center md:hidden">
            {user && <NotificationBell events={events} isMobile />}
            <Sheet open={isOpen} onOpenChange={setIsOpen}>
              <SheetTrigger asChild>
                <Button variant="ghost" size="icon" className="ml-2">
                  <Menu className="h-5 w-5" />
                </Button>
              </SheetTrigger>
              <SheetContent>
                <SheetHeader>
                  <SheetTitle>Navigation</SheetTitle>
                  <SheetDescription>
                    Access navigation links and account settings.
                  </SheetDescription>
                </SheetHeader>
                <div className="flex flex-col space-y-4 mt-8">
                  {isLandingPage ? (
                    <>
                      {publicLinks.map((link) => (
                        <button
                          key={link.id}
                          onClick={() => handleLinkClick(() => scrollToSection(link.id))}
                          className="text-foreground/80 hover:text-foreground transition-colors text-left"
                        >
                          {link.label}
                        </button>
                      ))}
                      {user && (
                        <Link
                          href="/dashboard"
                          onClick={() => handleLinkClick()}
                          className="text-foreground/80 hover:text-foreground transition-colors"
                        >
                          Dashboard
                        </Link>
                      )}
                    </>
                  ) : (
                    dashboardLinks.map((link) => (
                      <Link
                        key={link.href}
                        href={link.href}
                        onClick={() => handleLinkClick()}
                        className="text-foreground/80 hover:text-foreground transition-colors"
                      >
                        {link.label}
                      </Link>
                    ))
                  )}
                  {user ? (
                    <Button 
                      variant="ghost" 
                      onClick={() => handleLinkClick(handleSignOut)}
                      className="w-full justify-start font-medium"
                    >
                      Sign out
                    </Button>
                  ) : (
                    <>
                      <Link
                        href="/login"
                        onClick={() => handleLinkClick()}
                        className="w-full"
                      >
                        <Button 
                          variant="ghost" 
                          className="w-full justify-start font-medium"
                        >
                          Sign in
                        </Button>
                      </Link>
                      <Link
                        href="/signup"
                        onClick={() => handleLinkClick()}
                        className="w-full"
                      >
                        <Button 
                          className="w-full justify-start font-medium"
                        >
                          Sign up
                        </Button>
                      </Link>
                    </>
                  )}
                </div>
              </SheetContent>
            </Sheet>
          </div>
        </div>
      </div>
    </nav>
  );
}