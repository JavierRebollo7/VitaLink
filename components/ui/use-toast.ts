import { useToast as useToastOriginal } from "@/components/ui/toast";

export interface ToastProps {
  title?: string;
  description?: string;
  variant?: "default" | "destructive";
}

export function useToast() {
  const { toast } = useToastOriginal();
  
  return {
    toast: (props: ToastProps) => {
      toast(props);
    }
  };
} 