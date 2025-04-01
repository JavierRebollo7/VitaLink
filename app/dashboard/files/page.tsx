"use client";

import { useState, useEffect, useCallback } from 'react';
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { 
  Grid2X2, 
  List, 
  Search, 
  Upload,
  Filter,
  X,
  FileText,
  File
} from 'lucide-react';
import FileUploadZone from '@/components/file-upload-zone';
import FileGrid from '@/components/file-grid';
import FileList from '@/components/file-list';
import FilePreview from '@/components/file-preview';
import { useSearchParams } from 'next/navigation';
import FileUploadModal from '@/components/file-upload-modal';
import { Card } from '@/components/ui/card';
import FileFilters from '@/components/file-filters';
import ViewportMeta from '@/components/viewport-meta';
import { Badge } from '@/components/ui/badge';
import { DropdownMenu } from '@/components/ui/dropdown-menu';
import { Dialog, DialogContent, DialogDescription, DialogTitle } from '@/components/ui/dialog';
import Image from 'next/image';
import { useToast } from "@/components/ui/toast";
import { type ToastProps } from "@/components/ui/use-toast";

interface FileFilter {
  profile?: string;
  type?: string;
  category?: string;
  startDate?: string;
  endDate?: string;
}

interface Profile {
  id: string;
  name: string;
  image_url?: string;
}

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

type FileExtensionType = 'image' | 'pdf' | 'msword' | 'spreadsheet';

const fileTypeMap = {
  image: ['image', 'png', 'jpg', 'jpeg', 'gif'],
  pdf: ['pdf'],
  msword: ['word', 'document', 'docx', 'doc'],
  spreadsheet: ['excel', 'sheet', 'xlsx', 'xls']
} as const;

function isValidUUID(uuid: string) {
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
  return uuidRegex.test(uuid);
}

// First, let's create a reusable filter badge component
const FilterBadge = ({ type, value, onRemove }: { 
  type: string; 
  value: string; 
  onRemove: () => void;
}) => {
  return (
    <Badge
      variant="secondary"
      className="flex items-center gap-1"
    >
      {type}: {value}
      <X
        className="h-3 w-3 cursor-pointer"
        onClick={onRemove}
      />
    </Badge>
  );
};

export default function FilesPage() {
  const [files, setFiles] = useState<FileType[]>([]);
  const [profiles, setProfiles] = useState<Profile[]>([]);
  const [isGridView, setIsGridView] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [activeFilters, setActiveFilters] = useState<Record<string, string[]>>({});
  const [filters, setFilters] = useState<Record<string, string>>({});
  const [isUploadModalOpen, setIsUploadModalOpen] = useState(false);
  const [uploadFile, setUploadFile] = useState<File | null>(null);
  const [editingFile, setEditingFile] = useState<FileType | null>(null);
  const [selectedFile, setSelectedFile] = useState<FileType | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const searchParams = useSearchParams();
  const supabase = createClientComponentClient();
  const { toast } = useToast();

  const fetchProfiles = useCallback(async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('user_id', user.id);

      if (error) throw error;
      setProfiles(data || []);
    } catch (error) {
      console.error('Error fetching profiles:', error);
      setError('Failed to load profiles');
    }
  }, [supabase]);

  const fetchFiles = useCallback(async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      let query = supabase
        .from('files')
        .select('*')
        .eq('user_id', user.id);

      // Apply filters
      if (filters.profile) {
        query = query.eq('profile_id', filters.profile);
      }
      if (filters.type) {
        query = query.eq('type', filters.type);
      }
      if (filters.category) {
        query = query.eq('category', filters.category);
      }
      if (filters.startDate) {
        query = query.gte('created_at', filters.startDate);
      }
      if (filters.endDate) {
        query = query.lte('created_at', filters.endDate);
      }

      const { data, error } = await query;

      if (error) throw error;
      setFiles(data || []);
    } catch (error) {
      console.error('Error fetching files:', error);
      setError('Failed to load files');
    } finally {
      setIsLoading(false);
    }
  }, [supabase, filters]);

  useEffect(() => {
    // Get view preference from URL
    const view = searchParams.get('view');
    setIsGridView(view !== 'list');

    // Get all filter values from URL
    const urlFilters: Record<string, string[]> = {};
    
    // Handle profile filter
    const profileId = searchParams.get('profile');
    if (profileId) {
      urlFilters.profile = [profileId];
    }
    
    // Handle type filter
    const type = searchParams.get('type');
    if (type) {
      urlFilters.type = [type];
    }
    
    // Handle size filter
    const size = searchParams.get('size');
    if (size) {
      urlFilters.size = [size];
    }
    
    // Handle time filter
    const time = searchParams.get('time');
    if (time) {
      urlFilters.time = [time];
    }

    // Only set filters if there are any
    if (Object.keys(urlFilters).length > 0) {
      setActiveFilters(urlFilters);
      
      // Convert to filters format
      const convertedFilters: Record<string, string> = {};
      Object.entries(urlFilters).forEach(([key, values]) => {
        if (values && values.length > 0) {
          convertedFilters[key] = values[0];
        }
      });
      setFilters(convertedFilters);
    }

    // Fetch profiles and files only once on mount
    const initializeData = async () => {
      await fetchProfiles();
      await fetchFiles();
    };

    initializeData();
  }, [searchParams]);

  const handleFileUpload = async (fileData: {
    file: File;
    profileId?: string;
    documentType: string;
    category: string;
    description: string;
    tags: string[];
    name?: string;
  }) => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;
  
    const { file, profileId, documentType, category, description, tags, name } = fileData;
  
    console.log('Received profileId:', profileId, typeof profileId);

    // Only validate if profileId is provided
    if (profileId) {
      if (!isValidUUID(profileId)) {
        console.error('Invalid profile ID format:', profileId);
        return;
      }
    }
  
    // For new file uploads
    if (!editingFile) {
      const fileExt = file.name.split('.').pop();
      const filePath = `${user.id}/${Date.now()}.${fileExt}`;
  
      const { data: uploadData, error: uploadError } = await supabase.storage
        .from('files')
        .upload(filePath, file);
  
      if (uploadError) {
        console.error('Error uploading file:', uploadError);
        return;
      }
  
      const { data: { publicUrl } } = supabase.storage
        .from('files')
        .getPublicUrl(filePath);
  
      const { data, error } = await supabase
        .from('files')
        .insert({
          user_id: user.id,
          profile_id: profileId || null,
          name: name || file.name,
          type: file.type,
          document_type: documentType,
          category,
          description,
          tags,
          size: file.size,
          url: publicUrl,
          path: filePath,
        })
        .select()
        .single();
  
      if (error) {
        console.error('Error saving file metadata:', error);
        return;
      }
  
      setFiles(prev => [data, ...prev]);
    } else {
      // For editing existing files
      const { data, error } = await supabase
        .from('files')
        .update({
          profile_id: profileId || null,
          name: name,
          document_type: documentType,
          category,
          description,
          tags,
        })
        .eq('id', editingFile.id)
        .select()
        .single();
  
      if (error) {
        console.error('Error updating file metadata:', error);
        return;
      }
  
      // Update the files state by replacing the edited file
      setFiles(prev => prev.map(f => f.id === editingFile.id ? data : f));
    }
  
    setUploadFile(null);
    setEditingFile(null);
  };

  const handleEditFile = async (file: FileType) => {
    if (!file) return;
    setEditingFile(file);
  };

  const handleDeleteFile = async (file: FileType) => {
    if (!file) return;
    try {
      const { error } = await supabase
        .from('files')
        .delete()
        .eq('id', file.id);

      if (error) throw error;
      setFiles(prev => prev.filter(f => f.id !== file.id));
    } catch (error) {
      console.error('Error deleting file:', error);
      toast({
        variant: "destructive",
        title: "Error",
        description: "Failed to delete file",
      } as ToastProps);
    }
  };

  const handleFileSelect = (file: FileType) => {
    if (!file) return;
    setSelectedFile(file);
  };

  const handleUpdate = async (fileData: {
    name: string;
    profileId?: string;
    documentType: string;
    category: string;
    description: string;
    tags: string[];
  }) => {
    if (!editingFile) return;

    const { data, error } = await supabase
      .from('files')
      .update({
        name: fileData.name,
        profile_id: fileData.profileId || null,
        document_type: fileData.documentType,
        category: fileData.category,
        description: fileData.description,
        tags: fileData.tags,
      })
      .eq('id', editingFile.id)
      .select()
      .single();

    if (error) {
      console.error('Error updating file:', error);
      return;
    }

    setFiles(prev => prev.map(f => f.id === data.id ? data : f));
    setEditingFile(null);
    setUploadFile(null);
  };

  const handleFilterChange = (newFilters: any) => {
    setActiveFilters(newFilters);
    
    // Update URL with new filters
    const url = new URL(window.location.href);
    
    // Clear existing filter parameters
    ['profile', 'type', 'size', 'time'].forEach(param => {
      url.searchParams.delete(param);
    });
    
    // Add new filter parameters
    Object.entries(newFilters).forEach(([key, values]: [string, any]) => {
      if (values && values.length > 0) {
        url.searchParams.set(key, values[0]);
      }
    });
    
    // Update URL without reloading the page
    window.history.pushState({}, '', url.toString());
    
    // Convert and set filters
    const convertedFilters: any = {};
    Object.entries(newFilters).forEach(([key, values]: [string, any]) => {
      if (values && values.length > 0) {
        convertedFilters[key] = values[0];
      }
    });
    
    setFilters(convertedFilters);
  };

  const handleClearFilters = () => {
    setActiveFilters({});
    setFilters({});
    
    // Clear URL parameters
    const url = new URL(window.location.href);
    ['profile', 'type', 'size', 'time'].forEach(param => {
      url.searchParams.delete(param);
    });
    window.history.pushState({}, '', url.toString());
    
    fetchFiles();
  };

  const applyFilters = (files: FileType[]) => {
    return files.filter(file => {
      let passesFilters = true;

      if (activeFilters.profile?.length) {
        const fileProfileId = String(file.profile_id);
        if (!activeFilters.profile.includes(fileProfileId)) {
          passesFilters = false;
        }
      }

      if (activeFilters.size?.length) {
        const sizeMB = file.size / (1024 * 1024);
        if (!activeFilters.size.some(sizeFilter => {
          switch (sizeFilter) {
            case '<1': return sizeMB < 1;
            case '1-5': return sizeMB >= 1 && sizeMB <= 5;
            case '5-10': return sizeMB >= 5 && sizeMB <= 10;
            case '>10': return sizeMB > 10;
            default: return false;
          }
        })) {
          passesFilters = false;
        }
      }

      if (activeFilters.type?.length) {
        const typeMap: Record<string, string[]> = {
          'image': ['image'],
          'pdf': ['pdf'],
          'msword': ['word', 'msword', 'officedocument.word'],
          'spreadsheet': ['excel', 'spreadsheet']
        };
        
        if (!activeFilters.type.some(typeFilter => 
          typeMap[typeFilter]?.some(type => 
            file.type.toLowerCase().includes(type)
          )
        )) {
          passesFilters = false;
        }
      }

      if (activeFilters.time?.length) {
        const fileDate = new Date(file.created_at);
        const now = new Date();
        const diffHours = (now.getTime() - fileDate.getTime()) / (1000 * 60 * 60);
        
        if (!activeFilters.time.some(timeFilter => {
          switch (timeFilter) {
            case '24h': return diffHours <= 24;
            case '7d': return diffHours <= 24 * 7;
            case '30d': return diffHours <= 24 * 30;
            case '1y': return diffHours <= 24 * 365;
            default: return false;
          }
        })) {
          passesFilters = false;
        }
      }

      return passesFilters;
    });
  };

  const filteredFiles = applyFilters(files);

  const handleViewChange = (isGrid: boolean) => {
    const url = new URL(window.location.href);
    if (!isGrid) {
      url.searchParams.set('view', 'list');
    } else {
      url.searchParams.delete('view');
    }
    window.history.pushState({}, '', url.toString());
    setIsGridView(isGrid);
  };

  // Helper function to get profile name by ID
  const getProfileName = (profileId: string) => {
    const profile = profiles.find(p => p.id === profileId);
    return profile ? profile.name : 'Unknown';
  };

  const handleRemoveFilter = (key: string) => {
    const newFilters = { ...activeFilters };
    delete newFilters[key];
    setActiveFilters(newFilters);
    
    // Update URL
    const params = new URLSearchParams(searchParams.toString());
    params.delete(key);
    window.history.pushState({}, '', `?${params.toString()}`);
    
    // Update filters state
    const convertedFilters = { ...filters };
    delete convertedFilters[key];
    setFilters(convertedFilters);
  };

  const renderFilterBadge = (key: string, value: string) => {
    if (key === 'profile') {
      const profile = profiles.find(p => p.id === value);
      const displayName = profile ? profile.name : 'Unknown';
      return (
        <FilterBadge
          key={key}
          type="Profile"
          value={displayName}
          onRemove={() => handleRemoveFilter(key)}
        />
      );
    }
    // Handle other filter types...
    return (
      <FilterBadge
        key={key}
        type={key.charAt(0).toUpperCase() + key.slice(1)}
        value={value}
        onRemove={() => handleRemoveFilter(key)}
      />
    );
  };

  const getFileTypeIcon = (fileType: string): string[] => {
    const matchingType = Object.keys(fileTypeMap).find(type => 
      fileTypeMap[type as keyof typeof fileTypeMap].some(ext => 
        fileType.toLowerCase().includes(ext)
      )
    ) as FileExtensionType | undefined;

    return matchingType ? [...fileTypeMap[matchingType]] : [];
  };

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
    } else if (file.type.includes('word') || file.type.includes('document')) {
      return (
        <div className="w-full h-full bg-muted rounded-t-lg flex flex-col items-center justify-center gap-2">
          <FileText className="h-16 w-16 text-blue-500" />
          <span className="text-xs text-muted-foreground">Word Document</span>
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

  const showError = (message: string) => {
    toast({
      variant: "destructive",
      title: "Error",
      description: message,
    } as ToastProps);
  };

  return (
    <>
      <ViewportMeta />
      <main className="min-h-screen bg-background pt-20">
        <div className="container mx-auto px-4 py-8">
          <div className="flex flex-col space-y-8">
            <div className="flex flex-col space-y-4 sm:space-y-0 sm:flex-row sm:items-center sm:justify-between">
              <div className="flex justify-center sm:justify-start">
                <h1 className="text-2xl font-bold bg-gradient-to-r from-primary to-primary/60 text-primary-foreground px-4 py-2 rounded-lg inline-block w-fit">
                  Medical Records Database
                </h1>
              </div>
              <div className="flex items-center justify-center sm:justify-end space-x-2">
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={() => handleViewChange(true)}
                  className={isGridView ? 'bg-accent' : ''}
                >
                  <Grid2X2 className="h-5 w-5" />
                </Button>
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={() => handleViewChange(false)}
                  className={!isGridView ? 'bg-accent' : ''}
                >
                  <List className="h-5 w-5" />
                </Button>
              </div>
            </div>

            <div className="flex flex-col gap-4">
              <div className="flex-1 relative">
                <Search className="absolute left-3 top-3 h-4 w-4 text-muted-foreground" />
                <Input
                  placeholder="Search files..."
                  className="pl-9"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                />
              </div>
              
              <FileFilters
                profiles={profiles}
                onFilterChange={handleFilterChange}
                activeFilters={activeFilters}
                onClearFilters={handleClearFilters}
              />
            </div>

            <FileUploadZone
              setUploadFile={setUploadFile}
            />

            <div className="bg-background rounded-lg">
              {isGridView ? (
                <FileGrid
                  files={filteredFiles}
                  onFileSelect={handleFileSelect}
                  onDelete={handleDeleteFile}
                  onEdit={handleEditFile}
                  searchQuery={searchQuery}
                />
              ) : (
                <FileList
                  files={filteredFiles}
                  onFileSelect={handleFileSelect}
                  onDelete={handleDeleteFile}
                  onEdit={handleEditFile}
                  searchQuery={searchQuery}
                />
              )}
            </div>
          </div>
        </div>

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

        {uploadFile && !editingFile && (
          <FileUploadModal
            file={uploadFile}
            profiles={profiles}
            onSubmit={handleFileUpload}
            onClose={() => setUploadFile(null)}
          />
        )}

        {editingFile && uploadFile && (
          <FileUploadModal
            file={uploadFile}
            profiles={profiles}
            onSubmit={handleUpdate}
            onClose={() => setEditingFile(null)}
            editingFile={editingFile}
          />
        )}
      </main>
    </>
  );
} 