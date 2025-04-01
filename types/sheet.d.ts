import { ReactNode } from 'react';

declare module '@/components/ui/sheet' {
  export interface SheetContentProps {
    children?: ReactNode;
    side?: 'top' | 'right' | 'bottom' | 'left';
    className?: string;
    open?: boolean;
    onOpenChange?: (open: boolean) => void;
    forceMount?: boolean;
  }
} 