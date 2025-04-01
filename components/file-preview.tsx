"use client";

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

interface FilePreviewProps {
  file: {
    name: string;
    url: string;
    type: string;
  };
  onClose: () => void;
}

export default function FilePreview({ file, onClose }: FilePreviewProps) {
  return (
    <Dialog open={true} onOpenChange={() => onClose()}>
      <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>{file.name}</DialogTitle>
          <DialogDescription>
            Preview of your uploaded file
          </DialogDescription>
        </DialogHeader>
        
        <div className="relative w-full h-[calc(80vh-8rem)]">
          {file.type.startsWith('image/') ? (
            <img
              src={file.url}
              alt={file.name}
              className="w-full h-full object-contain"
            />
          ) : (
            <iframe
              src={file.url}
              className="w-full h-full"
              title={`Preview of ${file.name}`}
            />
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
} 