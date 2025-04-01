// @ts-nocheck
"use client";

import { Card } from '@/components/ui/card';
import { formatDistanceToNow } from 'date-fns';
import { 
  File,
  Image as ImageIcon,
  FileText,
  FileSpreadsheet,
  Download,
  Trash,
  Edit,
  Clock,
  HardDrive,
  Folder,
  User,
  UserCircle2
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import { useState, useEffect, useRef, useMemo, memo } from 'react';
import { Document, Page } from 'react-pdf';
import 'react-pdf/dist/esm/Page/AnnotationLayer.css';
import 'react-pdf/dist/esm/Page/TextLayer.css';
import '../lib/pdf-worker';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { Dialog, DialogContent, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import React from 'react';
import { motion, AnimatePresence } from "framer-motion";
import Image from 'next/image';

interface FileType {
  id: string;
  name: string;
  type: string;
  url: string;
  size: number;
  created_at: string;
  profile_id?: string;
  category?: string;
  tags?: string[];
}

interface FileGridProps {
  files: FileType[];
  textContents?: Record<string, string>;
  onFileSelect: (file: FileType) => void;
  onDelete: (file: FileType) => void;
  onEdit: (file: FileType) => void;
  searchQuery?: string;
}

interface Profile {
  id: string;
  name: string;
  image_url?: string;
}

type TextContent = {
  [key: string]: string;
};

const TAG_COLORS = [
  'bg-emerald-100',    // muted green
  'bg-sky-100',        // muted blue
  'bg-amber-100',      // muted orange
  'bg-rose-100',       // muted red
  'bg-violet-100',     // muted purple
  'bg-teal-100',       // muted teal
  'bg-cyan-100',       // muted cyan
  'bg-fuchsia-100',    // muted pink
  'bg-indigo-100',     // muted indigo
  'bg-slate-100',      // muted gray
  'bg-orange-100',     // muted orange
  'bg-lime-100',       // muted lime
];

const capitalizeFirstLetter = (string: string) => {
  return string.charAt(0).toUpperCase() + string.slice(1);
};

const getFileIcon = (fileType: string): React.ReactNode => {
  if (fileType.includes('text')) {
    return (
      <>
        <FileText className="h-16 w-16 text-gray-500" />
        <span className="text-xs text-muted-foreground">Text File</span>
      </>
    );
  }
  if (fileType.includes('word') || fileType.includes('document')) {
    return (
      <>
        <FileText className="h-16 w-16 text-blue-500" />
        <span className="text-xs text-muted-foreground">Word Document</span>
      </>
    );
  }
  return (
    <>
      <File className="h-16 w-16 text-gray-500" />
      <span className="text-xs text-muted-foreground">File</span>
    </>
  );
};

const formatTimeAgo = (date: Date) => {
  const now = new Date();
  const diffInSeconds = Math.floor((now.getTime() - date.getTime()) / 1000);
  const diffInMinutes = Math.floor(diffInSeconds / 60);
  const diffInHours = Math.floor(diffInMinutes / 60);
  const diffInDays = Math.floor(diffInHours / 24);

  if (diffInSeconds < 60) {
    return '0 minutes ago';
  } else if (diffInMinutes < 60) {
    return `${diffInMinutes} ${diffInMinutes === 1 ? 'minute' : 'minutes'} ago`;
  } else if (diffInHours < 24) {
    return `${diffInHours} ${diffInHours === 1 ? 'hour' : 'hours'} ago`;
  } else {
    return `${diffInDays} ${diffInDays === 1 ? 'day' : 'days'} ago`;
  }
};

// Create a memoized Office preview component
const MemoizedOfficePreview = React.memo(({ file }: { file: FileType }) => {
  const iframeRef = useRef<HTMLIFrameElement>(null);

  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      if (event.origin.includes('officeapps.live.com')) {
        // Handle any postMessage events from Office viewer if needed
      }
    };

    window.addEventListener('message', handleMessage);
    return () => window.removeEventListener('message', handleMessage);
  }, []);

  const getOfficePreviewUrl = (fileUrl: string) => {
    const timestamp = new Date().getTime();
    const encodedUrl = encodeURIComponent(fileUrl);
    return `https://view.officeapps.live.com/op/embed.aspx?src=${encodedUrl}&embedded=true&ui=true&rs=false&postMessageOrigin=${encodeURIComponent(window.location.origin)}&wdAllowInteractivity=True&wdHideGridlines=True&wdHideHeaders=True&wdDownloadButton=True&wdInConfigurator=True&_=${timestamp}`;
  };

  return (
    <iframe
      ref={iframeRef}
      src={getOfficePreviewUrl(file.url)}
      className="w-full h-full rounded-t-lg"
      title={file.name}
      sandbox="allow-scripts allow-same-origin allow-forms allow-popups allow-downloads allow-presentation allow-top-navigation allow-top-navigation-by-user-activation allow-modals"
      loading="lazy"
      referrerPolicy="origin"
      allow="clipboard-read; clipboard-write"
    />
  );
});
MemoizedOfficePreview.displayName = 'MemoizedOfficePreview';

const FileGrid = memo(({ files, textContents: initialTextContents = {}, onFileSelect, onDelete, onEdit, searchQuery }: FileGridProps) => {
  const [isDeleting, setIsDeleting] = useState<string | null>(null);
  const [profiles, setProfiles] = useState<{ [key: string]: Profile }>({});
  const [selectedFile, setSelectedFile] = useState<FileType | null>(null);
  const [showOfficeViewer, setShowOfficeViewer] = useState(false);
  const [textContents, setTextContents] = useState<Record<string, string>>(initialTextContents);
  const [loadingTexts, setLoadingTexts] = useState<Record<string, boolean>>({});
  const supabase = createClientComponentClient({
    options: {
      // @ts-ignore
      persistSession: false,
      cookieOptions: {
        sameSite: 'strict',
      }
    }
  });

  useEffect(() => {
    let mounted = true;

    const fetchProfiles = async () => {
      const profileIds = Array.from(new Set(files.map(file => file.profile_id).filter((id): id is string => id !== undefined)));
      
      if (profileIds.length === 0) {
        console.log('No profile IDs to fetch');
        return;
      }
    
      console.log('Fetching profiles for IDs:', profileIds);
    
      const { data, error } = await supabase
        .from('profiles')
        .select('id, name, image_url')
        .in('id', profileIds);
    
      if (error) {
        console.error('Error fetching profiles:', error);
        return;
      }
    
      if (data && mounted) {
        console.log('Received profile data:', data);
        const profileMap = data.reduce((acc: { [key: string]: Profile }, profile: Profile) => ({
          ...acc,
          [profile.id]: profile
        }), {});
        console.log('Created profile map:', profileMap);
        setProfiles(profileMap);
      }
    };

    fetchProfiles();

    return () => {
      mounted = false;
    };
  }, [files, supabase]);

  useEffect(() => {
    const hasOfficeFiles = files.some(
      file => file.type.includes('word') || 
              file.type.includes('excel') || 
              file.type.includes('powerpoint') ||
              file.type.includes('document')
    );
    setShowOfficeViewer(hasOfficeFiles);
  }, [files]);

  useEffect(() => {
    const fetchTextContent = async (file: FileType) => {
      if (!file.type.includes('text') || textContents[file.id]) return;
      
      setLoadingTexts(prev => ({ ...prev, [file.id]: true }));
      try {
        const response = await fetch(file.url);
        const text = await response.text();
        setTextContents(prev => ({ ...prev, [file.id]: text }));
      } catch (error) {
        console.error('Error fetching text content:', error);
        setTextContents(prev => ({ ...prev, [file.id]: 'Error loading content' }));
      } finally {
        setLoadingTexts(prev => ({ ...prev, [file.id]: false }));
      }
    };

    files.forEach(file => {
      if (file.type.includes('text')) {
        fetchTextContent(file);
      }
    });
  }, [files, textContents]);

  const getOfficePreviewUrl = (fileUrl: string) => {
    const timestamp = new Date().getTime();
    const encodedUrl = encodeURIComponent(fileUrl);
    return `https://view.officeapps.live.com/op/embed.aspx?src=${encodedUrl}&embedded=true&ui=true&rs=false&postMessageOrigin=${encodeURIComponent(window.location.origin)}&wdAllowInteractivity=True&wdHideGridlines=True&wdHideHeaders=True&wdDownloadButton=True&wdInConfigurator=True&_=${timestamp}`;
  };

  const handleDownload = (e: React.MouseEvent, file: FileType) => {
    e.stopPropagation();
    window.open(file.url, '_blank');
  };

  const handleDelete = async (e: React.MouseEvent, file: FileType) => {
    e.stopPropagation();
    setIsDeleting(file.id);
    try {
      await onDelete(file);
    } finally {
      setIsDeleting(null);
    }
  };

  // Memoize filtered files to prevent unnecessary re-renders
  const filteredFiles = useMemo(() => 
    files.filter(file => 
      !searchQuery || file.name.toLowerCase().includes(searchQuery.toLowerCase())
    ),
    [files, searchQuery]
  );

  const getFilePreview = (file: FileType, isModal: boolean = false) => {
    if (!file) return null;

    if (file.type.includes('image')) {
      return (
        <div className="relative w-full h-full">
          <Image
            src={file.url}
            alt={file.name}
            fill
            className="object-cover rounded-t-lg"
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          />
        </div>
      );
    } else if (file.type.includes('pdf')) {
      return (
        <iframe
          src={file.url}
          className="w-full h-full rounded-t-lg"
          title={file.name}
        />
      );
    } else if ((file.type.includes('word') || 
                file.type.includes('document') || 
                file.type.includes('excel') || 
                file.type.includes('spreadsheet')) && 
                showOfficeViewer) {
      return <MemoizedOfficePreview file={file} />;
    } else if (file.type.includes('word') || file.type.includes('document')) {
      return (
        <div className="w-full h-full bg-muted rounded-t-lg flex flex-col items-center justify-center gap-2">
          <FileText className="h-16 w-16 text-blue-500" />
          <span className="text-xs text-muted-foreground">Word Document</span>
        </div>
      );
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
          <File className="h-16 w-16 text-gray-500" />
          <span className="text-xs text-muted-foreground">Preview not available</span>
        </div>
      );
    }
  };

  const handlePreviewClick = (file: FileType) => {
    setSelectedFile(file);
  };

  return (
    <>
      <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {filteredFiles.map((file) => (
          <motion.div
            key={file.id}
            whileHover={{ scale: 1.02 }}
            transition={{ duration: 0.2 }}
          >
            <Card 
              className="overflow-hidden cursor-pointer group relative flex flex-col"
              onClick={() => handlePreviewClick(file)}
            >
              <div className="h-64 relative group cursor-pointer overflow-hidden">
                {getFilePreview(file, false)}
              </div>

              <div className="flex flex-col flex-1">
                <div className="p-2 space-y-2">
                  <h3 className="font-medium line-clamp-1">
                    {file.name.split('.').slice(0, -1).join('.') || file.name}
                  </h3>
                  
                  <div className="flex items-center space-x-2">
                    {file.profile_id && profiles[file.profile_id] && (
                      <div className="h-6 w-6 rounded-full overflow-hidden flex-shrink-0 bg-muted flex items-center justify-center">
                        {profiles[file.profile_id].image_url ? (
                          <img 
                            src={profiles[file.profile_id].image_url}
                            alt={profiles[file.profile_id].name}
                            className="h-full w-full object-cover"
                            style={{ imageRendering: 'crisp-edges' }}
                            loading="lazy"
                          />
                        ) : (
                          <User className="h-4 w-4 text-primary/40" />
                        )}
                      </div>
                    )}
                    <span className="text-sm text-muted-foreground truncate">
                      {file.profile_id && profiles[file.profile_id] ? profiles[file.profile_id].name : 'No Profile'}
                    </span>
                  </div>

                  <div className="flex items-center space-x-1.5 text-muted-foreground">
                    <Clock className="h-3.5 w-3.5" />
                    <span>
                      {formatTimeAgo(new Date(file.created_at))}
                    </span>
                  </div>

                  <div className="flex items-center space-x-1.5 text-muted-foreground">
                    <HardDrive className="h-3.5 w-3.5" />
                    <span>{(file.size / 1024 / 1024).toFixed(2)} MB</span>
                  </div>

                  {file.category && (
                    <div className="flex items-center space-x-1.5 text-muted-foreground">
                      <Folder className="h-3.5 w-3.5" />
                      <span className="capitalize text-sm">{file.category}</span>
                    </div>
                  )}

                  {file.tags && file.tags.length > 0 && (
                    <div className="flex flex-wrap gap-2">
                      {file.tags.map((tag, index) => {
                        const randomColor = TAG_COLORS[Math.floor(Math.random() * TAG_COLORS.length)];
                        return (
                          <span
                            key={index}
                            className={`px-2 py-1 rounded-md text-xs ${randomColor} text-gray-700 font-medium`}
                          >
                            {capitalizeFirstLetter(tag)}
                          </span>
                        );
                      })}
                    </div>
                  )}
                </div>

                <div className="flex items-center justify-end space-x-1 p-2 mt-auto">
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-8 w-8 bg-background/50 hover:bg-background/80"
                    onClick={(e) => handleDownload(e, file)}
                  >
                    <Download className="h-4 w-4" />
                  </Button>
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-8 w-8 bg-background/50 hover:bg-background/80"
                    onClick={(e) => {
                      e.stopPropagation();
                      onEdit(file);
                    }}
                  >
                    <Edit className="h-4 w-4" />
                  </Button>
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-8 w-8 bg-background/50 hover:bg-background/80 text-destructive hover:text-destructive"
                    onClick={(e) => handleDelete(e, file)}
                    disabled={isDeleting === file.id}
                  >
                    <Trash className="h-4 w-4" />
                  </Button>
                </div>
              </div>
            </Card>
          </motion.div>
        ))}
      </div>

      {/* Preview Modal */}
      <Dialog open={!!selectedFile} onOpenChange={() => setSelectedFile(null)}>
        <DialogContent className="max-w-4xl h-[80vh] flex flex-col">
          <DialogTitle className="sr-only">
            File Preview: {selectedFile?.name}
          </DialogTitle>
          <DialogDescription className="sr-only">
            Preview of file {selectedFile?.name}
          </DialogDescription>
          
          {selectedFile && (
            <div className="flex-1 min-h-0">
              {getFilePreview(selectedFile, true)}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </>
  );
});

FileGrid.displayName = 'FileGrid';

export default FileGrid; 