// @ts-nocheck
"use client";

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useState, useEffect } from "react";
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs';

interface FileUploadModalProps {
  file: File;
  profiles: any[];
  onSubmit: (fileData: {
    file: File;
    name: string;
    profileId?: string;
    documentType: string;
    category: string;
    description: string;
    tags: string[];
  }) => void;
  onClose: () => void;
  editingFile?: any;
}

export default function FileUploadModal({ file, profiles, onSubmit, onClose, editingFile }: FileUploadModalProps) {
  const [formData, setFormData] = useState({
    name: editingFile?.name || file?.name || '',
    profileId: editingFile?.profile_id || '',
    documentType: editingFile?.document_type || '',
    category: editingFile?.category || '',
    description: editingFile?.description || '',
    tags: editingFile?.tags ? editingFile.tags.join(', ') : '',
  });

  const documentTypes = [
    { id: "medical_record", label: "Medical Record" },
    { id: "lab_result", label: "Lab Result" },
    { id: "prescription", label: "Prescription" },
    { id: "insurance", label: "Insurance Document" },
    { id: "legal", label: "Legal Document" },
    { id: "other", label: "Other" }
  ];

  const categories = [
    { id: "health", label: "Health" },
    { id: "insurance", label: "Insurance" },
    { id: "legal", label: "Legal" },
    { id: "education", label: "Education" },
    { id: "financial", label: "Financial" },
    { id: "other", label: "Other" }
  ];

  const supabase = createClientComponentClient({  
    options: {
      // @ts-ignore
      persistSession: false,
      cookieOptions: {
        sameSite: 'strict',
      }
    }
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Submitting form data:', formData);
    
    await onSubmit({
      file,
      name: formData.name,
      profileId: formData.profileId || undefined,
      documentType: formData.documentType,
      category: formData.category,
      description: formData.description,
      tags: formData.tags.split(',').map((tag: string) => tag.trim()).filter((tag: string) => tag !== ''),
    });
    
    onClose();
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  return (
    <Dialog open={true} onOpenChange={onClose}>
      <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{editingFile ? 'Edit File' : 'Upload File'}</DialogTitle>
          <DialogDescription>
            {editingFile ? 'Edit file details' : 'Add details to your file'}
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="name">File Name</Label>
            <Input
              id="name"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="profile">Related Profile</Label>
            <Select
              name="profileId"
              value={formData.profileId || ''}
              onValueChange={(value) => {
                console.log('Selected profile ID:', value);
                handleInputChange({ 
                  target: { 
                    name: 'profileId', 
                    value: value || '' 
                  } 
                } as React.ChangeEvent<HTMLInputElement>);
              }}
            >
              <SelectTrigger>
                <SelectValue placeholder="Select profile" />
              </SelectTrigger>
              <SelectContent>
                {profiles.map((profile) => (
                  <SelectItem key={profile.id} value={profile.id}>
                    {profile.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="documentType">Document Type</Label>
            <Select
              value={formData.documentType}
              onValueChange={(value) => 
                setFormData(prev => ({ ...prev, documentType: value }))
              }
              required
            >
              <SelectTrigger>
                <SelectValue placeholder="Select document type" />
              </SelectTrigger>
              <SelectContent>
                {documentTypes.map((type) => (
                  <SelectItem key={type.id} value={type.id}>
                    {type.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="category">Category</Label>
            <Select
              value={formData.category}
              onValueChange={(value) => 
                setFormData(prev => ({ ...prev, category: value }))
              }
              required
            >
              <SelectTrigger>
                <SelectValue placeholder="Select category" />
              </SelectTrigger>
              <SelectContent>
                {categories.map((category) => (
                  <SelectItem key={category.id} value={category.id}>
                    {category.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="description">Description</Label>
            <Input
              id="description"
              name="description"
              value={formData.description}
              onChange={handleInputChange}
              placeholder="Brief description of the document"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="tags">Tags</Label>
            <Input
              id="tags"
              name="tags"
              value={formData.tags}
              onChange={handleInputChange}
              placeholder="Enter tags separated by commas"
            />
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={onClose}>
              Cancel
            </Button>
            <Button type="submit">
              {editingFile ? 'Submit' : 'Upload'}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
} 