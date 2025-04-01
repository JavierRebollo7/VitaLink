// @ts-nocheck
"use client";

import { Card } from '@/components/ui/card';
import { Dialog, DialogContent, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import { formatDistanceToNow } from 'date-fns';
import { Download, Trash, Edit, Clock, HardDrive, User } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { useState, useEffect } from 'react';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { getFilePreview } from "@/lib/file-preview";
import { motion, AnimatePresence } from "framer-motion";

// Add color constants
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

interface Profile {
  id: string;
  name: string;
  image_url?: string;
}

interface FileListProps {
  files: any[];
  onFileSelect: (file: any) => void;
  onDelete: (file: any) => void;
  onEdit: (file: any) => void;
  searchQuery?: string;
}

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

export default function FileList({ files, onFileSelect, onDelete, onEdit, searchQuery }: FileListProps) {
  const [profiles, setProfiles] = useState<{ [key: string]: Profile }>({});
  const [selectedFile, setSelectedFile] = useState<FileType | null>(null);
  const [textContents, setTextContents] = useState<Record<string, string>>({});
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
      const profileIds = [...new Set(files.map(file => file.profile_id))].filter(id => id !== null);
      
      if (profileIds.length === 0) return;
    
      const { data, error } = await supabase
        .from('profiles')
        .select('id, name, image_url')
        .in('id', profileIds);

      if (error) {
        console.error('Error fetching profiles:', error);
        return;
      }

      if (data && mounted) {
        const profileMap = data.reduce((acc, profile) => ({
          ...acc,
          [profile.id]: profile
        }), {});
        setProfiles(profileMap);
      }
    };

    fetchProfiles();

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

    return () => {
      mounted = false;
    };
  }, [files]);

  const handleDownload = (e: React.MouseEvent, file: any) => {
    e.stopPropagation();
    window.open(file.url, '_blank');
  };

  const handleDelete = async (e: React.MouseEvent, file: any) => {
    e.stopPropagation();
    await onDelete(file);
  };

  const handlePreviewClick = (file: FileType) => {
    setSelectedFile(file);
  };

  const filteredFiles = files.filter(file => 
    !searchQuery || file.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <>
      <div className="space-y-2">
        <AnimatePresence mode="popLayout">
          {filteredFiles.map((file, index) => (
            <motion.div
              key={file.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -20 }}
              transition={{ duration: 0.2, delay: index * 0.05 }}
              layout
            >
              <Card
                className="flex flex-col sm:flex-row items-start sm:items-center p-4 cursor-pointer hover:shadow-md transition-shadow gap-4"
                onClick={() => handlePreviewClick(file)}
              >
                {/* Mobile Layout */}
                <div className="flex flex-col w-full sm:hidden gap-3">
                  <div className="flex justify-between items-start">
                    <div className="flex items-center justify-between">
                      <span className="font-medium">
                        {file.name.split('.').slice(0, -1).join('.') || file.name}
                      </span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={(e) => handleDownload(e, file)}
                      >
                        <Download className="h-4 w-4" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
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
                        className="h-8 w-8"
                        onClick={(e) => handleDelete(e, file)}
                      >
                        <Trash className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>

                  <div className="flex items-center gap-2">
                    <div className="h-6 w-6 rounded-full overflow-hidden flex-shrink-0 bg-muted flex items-center justify-center">
                      {file.profile_id && profiles[file.profile_id]?.image_url ? (
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
                    <span className="text-sm text-muted-foreground truncate">
                      {file.profile_id ? (profiles[file.profile_id]?.name || 'Loading...') : 'No Profile'}
                    </span>
                  </div>

                  <div className="flex flex-wrap gap-2">
                    <div className="flex items-center space-x-1.5 text-sm text-muted-foreground">
                      <Clock className="h-3.5 w-3.5" />
                      <span>{formatTimeAgo(new Date(file.created_at))}</span>
                    </div>
                    <div className="flex items-center space-x-1.5 text-sm text-muted-foreground">
                      <HardDrive className="h-3.5 w-3.5" />
                      <span>{(file.size / 1024 / 1024).toFixed(2)} MB</span>
                    </div>
                  </div>

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

                {/* Desktop Layout */}
                <div className="hidden sm:flex flex-1 min-w-0 items-center gap-4">
                  {/* Existing desktop layout code */}
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between">
                      <span className="font-medium">
                        {file.name.split('.').slice(0, -1).join('.') || file.name}
                      </span>
                    </div>
                    {file.tags && file.tags.length > 0 && (
                      <div className="flex flex-wrap gap-2 mt-2">
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

                  <div className="flex items-center gap-2">
                    <div className="h-6 w-6 rounded-full overflow-hidden flex-shrink-0 bg-muted flex items-center justify-center">
                      {file.profile_id && profiles[file.profile_id]?.image_url ? (
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
                    <span className="text-sm text-muted-foreground truncate">
                      {file.profile_id ? (profiles[file.profile_id]?.name || 'Loading...') : 'No Profile'}
                    </span>
                  </div>

                  <div className="flex items-center gap-4 text-sm text-muted-foreground min-w-[200px]">
                    <div className="flex items-center space-x-1.5">
                      <Clock className="h-3.5 w-3.5" />
                      <span>{formatTimeAgo(new Date(file.created_at))}</span>
                    </div>
                    <div className="flex items-center space-x-1.5">
                      <HardDrive className="h-3.5 w-3.5" />
                      <span>{(file.size / 1024 / 1024).toFixed(2)} MB</span>
                    </div>
                  </div>

                  <div className="flex items-center gap-1">
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={(e) => handleDownload(e, file)}
                    >
                      <Download className="h-4 w-4" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
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
                      onClick={(e) => handleDelete(e, file)}
                    >
                      <Trash className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              </Card>
            </motion.div>
          ))}
        </AnimatePresence>
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
              {getFilePreview({
                file: selectedFile,
                isModal: true,
                textContents,
                loadingTexts
              })}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </>
  );
} 