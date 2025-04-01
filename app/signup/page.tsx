"use client";

import { Auth } from '@supabase/auth-ui-react';
import { ThemeSupa } from '@supabase/auth-ui-shared';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { useRouter } from 'next/navigation';
import { useEffect } from 'react';

export default function SignupPage() {
  const supabase = createClientComponentClient();
  const router = useRouter();

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event) => {
      if (event === 'SIGNED_IN') {
        router.push('/dashboard');
      }
    });

    return () => subscription.unsubscribe();
  }, [supabase.auth, router]);

  return (
    <main className="flex min-h-[calc(100vh-64px)] items-center justify-center -mt-16">
      <div className="w-full max-w-md px-4">
        <div className="bg-card rounded-lg p-8">
          <h1 className="text-2xl font-bold text-center mb-8">Create an Account</h1>
          <Auth
            supabaseClient={supabase}
            view="sign_up"
            appearance={{
              theme: ThemeSupa,
              variables: {
                default: {
                  colors: {
                    brand: 'rgb(var(--primary))',
                    brandAccent: 'rgb(var(--primary))',
                  },
                },
              },
              className: {
                container: 'w-full',
                button: 'w-full',
                anchor: 'text-primary',
              },
            }}
            providers={['google', 'github']}
            localization={{
              variables: {
                sign_up: {
                  social_provider_text: "Sign up with {{provider}}"
                }
              }
            }}
          />
        </div>
      </div>
    </main>
  );
}