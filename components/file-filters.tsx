// @ts-nocheck
"use client";

import { Button } from "@/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { X } from "lucide-react";
import { useEffect, useState, useCallback, useRef, useMemo } from "react";

interface FileFiltersProps {
  profiles: any[];
  onFilterChange: (filters: any) => void;
  activeFilters: {
    profile?: string[];
    size?: string[];
    type?: string[];
    time?: string[];
  };
  onClearFilters: () => void;
}

const timeRanges = [
  { label: 'Last 24 hours', value: '24h' },
  { label: 'Last 7 days', value: '7d' },
  { label: 'Last 30 days', value: '30d' },
  { label: 'Last year', value: '1y' },
];

const sizeRanges = [
  { label: '< 1MB', value: '<1' },
  { label: '1MB - 5MB', value: '1-5' },
  { label: '5MB - 10MB', value: '5-10' },
  { label: '> 10MB', value: '>10' },
];

const fileTypes = [
  { label: 'Images', value: 'image' },
  { label: 'PDFs', value: 'pdf' },
  { label: 'Word Documents', value: 'msword' },
  { label: 'Excel Sheets', value: 'spreadsheet' }
];

const formatFilterLabel = (type: string, value: string, profiles: any[]) => {
  switch (type) {
    case 'profile':
      const profile = profiles.find(p => p.id === value);
      return `Profile: ${profile?.name || 'Unknown'}`;
    
    case 'size':
      const sizeLabels = {
        '<1': 'File Size: < 1 MB',
        '1-5': 'File Size: 1-5 MB',
        '5-10': 'File Size: 5-10 MB',
        '>10': 'File Size: > 10 MB'
      };
      // @ts-ignore
      return sizeLabels[value] || value;
    
    case 'type':
      const typeLabels = {
        'image': 'Type: Image',
        'document': 'Type: Document',
        'video': 'Type: Video',
        'audio': 'Type: Audio',
        'other': 'Type: Other'
      };
      // @ts-ignore
      return typeLabels[value] || value;
    
    case 'time':
      const timeLabels = {
        '24h': 'Time: Last 24 hours',
        '7d': 'Time: Last 7 days',
        '30d': 'Time: Last 30 days',
        '1y': 'Time: Last year'
      };
      return timeLabels[value] || value;
    
    default:
      return `${type.charAt(0).toUpperCase() + type.slice(1)}: ${value}`;
  }
};

export default function FileFilters({ profiles, onFilterChange, activeFilters, onClearFilters }: FileFiltersProps) {
  const [localFilters, setLocalFilters] = useState(activeFilters);
  const filtersRef = useRef(activeFilters);
  const isFirstRender = useRef(true);

  // Update ref and local state when activeFilters changes
  useEffect(() => {
    if (!isFirstRender.current) {
      filtersRef.current = activeFilters;
      setLocalFilters(activeFilters);
    }
    isFirstRender.current = false;
  }, [activeFilters]);

  const handleFilterChange = useCallback((type: string, value: string) => {
    const currentFilters = filtersRef.current;
    const currentValues = currentFilters[type] || [];
    
    if (currentValues.includes(value)) {
      return;
    }
    
    const newValue = type === 'profile' ? String(value) : value;
    const newFilters = {
      ...currentFilters,
      [type]: [...currentValues, newValue]
    };
    
    filtersRef.current = newFilters;
    setLocalFilters(newFilters);
    onFilterChange(newFilters);
  }, [onFilterChange]);

  const handleRemoveFilter = useCallback((type: string, valueToRemove: string) => {
    const currentFilters = filtersRef.current;
    const newFilters = { ...currentFilters };
    newFilters[type] = newFilters[type].filter(value => value !== valueToRemove);
    
    if (newFilters[type].length === 0) {
      delete newFilters[type];
    }
    
    filtersRef.current = newFilters;
    setLocalFilters(newFilters);
    onFilterChange(newFilters);
  }, [onFilterChange]);

  const handleClearFilters = useCallback(() => {
    const emptyFilters = {};
    filtersRef.current = emptyFilters;
    setLocalFilters(emptyFilters);
    onClearFilters();
  }, [onClearFilters]);

  // Memoize the filter badges to prevent unnecessary re-renders
  const filterBadges = useMemo(() => {
    if (Object.entries(localFilters).length === 0) return null;

    return (
      <>
        <div className="flex flex-wrap gap-2 mt-4">
          {Object.entries(localFilters).map(([type, values]) => 
            values.map((value: string) => (
              <Badge
                key={`${type}-${value}`}
                variant="secondary"
                className="px-3 py-1"
              >
                {formatFilterLabel(type, value, profiles)}
                <X
                  className="h-3 w-3 ml-2 cursor-pointer"
                  onClick={() => handleRemoveFilter(type, value)}
                />
              </Badge>
            ))
          )}
        </div>
        
        <Button
          variant="ghost"
          size="sm"
          onClick={handleClearFilters}
          className="w-full sm:w-auto mt-4"
        >
          <X className="h-4 w-4 mr-2" />
          Clear Filters
        </Button>
      </>
    );
  }, [localFilters, profiles, handleRemoveFilter, handleClearFilters]);

  return (
    <div className="bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 p-4 rounded-lg border shadow-sm">
      <div className="flex flex-col sm:flex-row gap-4">
        <Select onValueChange={(value) => handleFilterChange('profile', value)} value="">
          <SelectTrigger className="w-full sm:w-[180px] bg-purple-50">
            <SelectValue placeholder="Related Profile" />
          </SelectTrigger>
          <SelectContent>
            {profiles.map((profile) => (
              <SelectItem key={profile.id} value={profile.id}>
                {profile.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select onValueChange={(value) => handleFilterChange('size', value)} value="">
          <SelectTrigger className="w-full sm:w-[180px] bg-blue-50">
            <SelectValue placeholder="File Size" />
          </SelectTrigger>
          <SelectContent>
            {sizeRanges.map((range) => (
              <SelectItem key={range.value} value={range.value}>
                {range.label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select onValueChange={(value) => handleFilterChange('type', value)} value="">
          <SelectTrigger className="w-full sm:w-[180px] bg-green-50">
            <SelectValue placeholder="File Type" />
          </SelectTrigger>
          <SelectContent>
            {fileTypes.map((type) => (
              <SelectItem key={type.value} value={type.value}>
                {type.label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select onValueChange={(value) => handleFilterChange('time', value)} value="">
          <SelectTrigger className="w-full sm:w-[180px] bg-yellow-50">
            <SelectValue placeholder="Time Range" />
          </SelectTrigger>
          <SelectContent>
            {timeRanges.map((range) => (
              <SelectItem key={range.value} value={range.value}>
                {range.label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      {filterBadges}
    </div>
  );
} 