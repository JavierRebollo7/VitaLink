"use client";

import { useState, useEffect } from 'react';
import { Button } from "@/components/ui/button";
import Image from "next/image";
import Link from "next/link";
import { ArrowRight, Shield, Zap, Heart, Check } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Switch } from '@/components/ui/switch';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';

export default function Home() {
  const [isAnnual, setIsAnnual] = useState(false);
  const [user, setUser] = useState<any>(null);
  const supabase = createClientComponentClient();

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

  const scrollToFeatures = () => {
    const featuresSection = document.getElementById('features');
    if (featuresSection) {
      const offset = 80; // height of navbar plus some padding
      const elementPosition = featuresSection.getBoundingClientRect().top;
      const offsetPosition = elementPosition + window.pageYOffset - offset;

      window.scrollTo({
        top: offsetPosition,
        behavior: 'smooth'
      });
    }
  };

  const plans = [
    {
      name: "Free",
      price: { monthly: 0, annual: 0 },
      description: "Perfect for getting started",
      features: [
        "1 child profile",
        "Basic health record storage",
        "Emergency information card",
        "Basic AI health assistant",
        "Appointment reminders",
      ],
    },
    {
      name: "Premium",
      price: { monthly: 9.99, annual: 99 },
      description: "Ideal for growing families",
      features: [
        "Up to 3 child profiles",
        "Advanced health analytics",
        "Priority AI assistance",
        "Document scanning & OCR",
        "Healthcare provider sharing",
        "Custom health alerts",
        "24/7 nurse hotline access",
      ],
      popular: true,
    },
    {
      name: "Family",
      price: { monthly: 19.99, annual: 199 },
      description: "Complete family coverage",
      features: [
        "Unlimited child profiles",
        "Family health insights",
        "Premium AI health assistant",
        "Priority support",
        "Custom health dashboards",
        "Family health history tracking",
        "Specialist referral network",
        "Emergency support",
      ],
    },
  ];

  return (
    <>
      {/* Hero Section */}
      <section className="relative pt-32 pb-16 md:pt-40 md:pb-24 bg-muted/50">
        <div className="container px-4 mx-auto">
          <div className="flex flex-col md:flex-row items-center">
            <div className="flex-1 text-center md:text-left mb-12 md:mb-0">
              <h1 className="text-4xl md:text-6xl font-bold tracking-tight mb-6">
                Smart Health Records<br />
                for Your{" "}
                <span className="text-primary">Family</span>
              </h1>
              <p className="text-xl text-muted-foreground mb-8 max-w-2xl">
                Keep track of your children&apos;s health records with AI-powered
                assistance. Get instant insights and professional guidance.
              </p>
              <div className="flex flex-col sm:flex-row gap-4 justify-center md:justify-start">
                <Button size="lg" asChild>
                  <Link href={user ? "/dashboard" : "/signup"}>
                    Get Started <ArrowRight className="ml-2 h-5 w-5" />
                  </Link>
                </Button>
                <Button 
                  variant="outline" 
                  size="lg"
                  onClick={scrollToFeatures}
                >
                  Learn More
                </Button>
              </div>
            </div>
            <div className="flex-1">
              <Image
                src="https://images.unsplash.com/photo-1516627145497-ae6968895b74?auto=format&fit=crop&q=80"
                alt="Happy family"
                width={600}
                height={400}
                className="rounded-lg shadow-2xl w-full h-auto"
                priority
              />
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-16 md:py-24">
        <div className="container px-4 mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              Why Choose VitaLink?
            </h2>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto">
              We provide the tools you need to manage your children&apos;s health
              records effectively and securely.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {[
              {
                icon: <Zap className="h-8 w-8" />,
                title: "AI-Powered Assistance",
                description:
                  "Get instant insights and recommendations from our advanced AI system.",
              },
              {
                icon: <Shield className="h-8 w-8" />,
                title: "Secure Storage",
                description:
                  "Your data is protected with enterprise-grade security and encryption.",
              },
              {
                icon: <Heart className="h-8 w-8" />,
                title: "Family-Focused",
                description:
                  "Designed specifically for families to manage multiple children's records.",
              },
            ].map((feature, index) => (
              <div
                key={index}
                className="bg-background rounded-lg p-8 shadow-sm hover:shadow-md transition-shadow"
              >
                <div className="text-primary mb-4">{feature.icon}</div>
                <h3 className="text-xl font-semibold mb-3">{feature.title}</h3>
                <p className="text-muted-foreground">{feature.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section id="pricing" className="py-16 md:py-24 bg-muted/50">
        <div className="container px-4 mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              Simple, Transparent Pricing
            </h2>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto mb-8">
              Choose the perfect plan for your family&apos;s needs. All plans include our core features.
            </p>
            
            <div className="flex items-center justify-center gap-4 mb-8">
              <span className={!isAnnual ? 'font-semibold' : 'text-muted-foreground'}>Monthly</span>
              <Switch
                checked={isAnnual}
                onCheckedChange={setIsAnnual}
              />
              <span className={isAnnual ? 'font-semibold' : 'text-muted-foreground'}>
                Annual <span className="text-green-600 font-medium">(Save 17%)</span>
              </span>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-7xl mx-auto">
            {plans.map((plan) => (
              <Card 
                key={plan.name}
                className={`relative flex flex-col ${plan.popular ? 'border-primary shadow-lg' : ''}`}
              >
                {plan.popular && (
                  <div className="absolute -top-4 left-1/2 -translate-x-1/2 px-4 py-1 bg-primary text-primary-foreground rounded-full text-sm font-medium">
                    Most Popular
                  </div>
                )}
                <CardHeader>
                  <CardTitle className="text-2xl font-bold">
                    {plan.name}
                  </CardTitle>
                  <div className="mt-4">
                    <span className="text-4xl font-bold">
                      ${isAnnual ? plan.price.annual : plan.price.monthly}
                    </span>
                    {plan.price.monthly > 0 && (
                      <span className="text-muted-foreground ml-2">
                        /{isAnnual ? 'year' : 'month'}
                      </span>
                    )}
                    <p className="text-muted-foreground mt-2">{plan.description}</p>
                  </div>
                </CardHeader>
                <CardContent className="flex flex-col flex-grow">
                  <ul className="space-y-4 mb-8 flex-grow">
                    {plan.features.map((feature) => (
                      <li key={feature} className="flex items-center gap-3">
                        <Check className="h-5 w-5 text-primary flex-shrink-0" />
                        <span>{feature}</span>
                      </li>
                    ))}
                  </ul>
                  <Button className="w-full" variant={plan.popular ? "default" : "outline"}>
                    Get Started
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>
    </>
  );
}