import { FileText } from "lucide-react";
import { MemoizedOfficePreview } from "@/components/office-preview";

interface FilePreviewProps {
  file: any;
  isModal?: boolean;
  textContents?: Record<string, string>;
  loadingTexts?: Record<string, boolean>;
}

export const getFilePreview = ({ file, isModal = false, textContents = {}, loadingTexts = {} }: FilePreviewProps) => {
  if (!file) return null;

  if (file.type.includes('image')) {
    return (
      <img
        src={file.url}
        alt={file.name}
        className="w-full h-full object-cover rounded-t-lg"
      />
    );
  } else if (file.type.includes('pdf')) {
    return (
      <iframe
        src={file.url}
        className="w-full h-full rounded-t-lg"
        title={file.name}
      />
    );
  } else if (
    file.type.includes('word') || 
    file.type.includes('document') || 
    file.type.includes('excel') || 
    file.type.includes('spreadsheet')
  ) {
    return <MemoizedOfficePreview file={file} />;
  } else if (file.type.includes('text')) {
    if (isModal) {
      return (
        <div className="h-full flex flex-col">
          <div className="flex-1 overflow-y-auto">
            <pre className="text-sm text-gray-700 whitespace-pre-wrap p-4">
              {loadingTexts[file.id] ? 'Loading...' : textContents[file.id] || 'No content available'}
            </pre>
          </div>
        </div>
      );
    }
    
    return (
      <div className="h-full bg-white p-4 overflow-hidden">
        <pre className="text-sm text-gray-700 whitespace-pre-wrap line-clamp-6">
          {loadingTexts[file.id] ? 'Loading...' : textContents[file.id] || 'No content available'}
        </pre>
      </div>
    );
  } else {
    return (
      <div className="w-full h-full bg-muted rounded-t-lg flex flex-col items-center justify-center gap-2">
        <FileText className="h-16 w-16 text-gray-500" />
        <span className="text-xs text-muted-foreground">Preview not available</span>
      </div>
    );
  }
}; 