"use client";

import { useEffect } from 'react';

export default function ViewportMeta() {
  useEffect(() => {
    // Find existing viewport meta
    const viewport = document.querySelector('meta[name="viewport"]');
    
    if (viewport) {
      // Update existing viewport
      viewport.setAttribute('content', 
        'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'
      );
    } else {
      // Create new viewport meta if it doesn't exist
      const meta = document.createElement('meta');
      meta.name = 'viewport';
      meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
      document.head.appendChild(meta);
    }
  }, []);

  return null;
} 