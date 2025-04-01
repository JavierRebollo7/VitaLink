# VitaLink

A comprehensive medical records management and AI-assisted healthcare application.

The app is currently live, so start to take control of your family's health with [VitaLink](https://vitalink-gamma.vercel.app/)!

## Prerequisites

- Node.js 18.x or later
- npm or yarn
- Supabase account
- Google Maps API key
- OpenAI API key

## Setup Instructions

1. Clone the repository:
```bash
git clone <repository-url>
cd vitalink
```

2. Install dependencies:
```bash
npm install
# or
yarn install
```

3. Set up environment variables:
   - Copy `.env.example` to `.env.local`
   - Fill in your environment variables:
     - `NEXT_PUBLIC_SUPABASE_URL`: Your Supabase project URL
     - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Your Supabase anonymous key
     - `NEXT_PUBLIC_GOOGLE_MAPS_API_KEY`: Your Google Maps API key
     - `OPENAI_API_KEY`: Your OpenAI API key

4. Run the development server:
```bash
npm run dev
# or
yarn dev
```

5. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Features

- Medical Records Management
- AI-Assisted Healthcare Assistant
- Calendar Integration
- File Management
- Profile Management
- Interactive Map View

## Tech Stack

- Next.js 14
- TypeScript
- Supabase
- OpenAI
- Google Maps API
- Tailwind CSS
- Shadcn UI