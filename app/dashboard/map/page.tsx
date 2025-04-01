// @ts-nocheck

"use client";

import { useState, useEffect } from 'react';
import { GoogleMap, useLoadScript, Marker, InfoWindow } from '@react-google-maps/api';
import { Card } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Building2,
  Pill,
  Stethoscope,
  MapPin,
  Star,
  MessageSquare,
  Navigation,
  Loader2,
  Check,
  X
} from 'lucide-react';
import { Slider } from "@/components/ui/slider";
import React from 'react';
import { cn } from '@/lib/utils';

interface Facility {
  id: string;
  name: string;
  address: string;
  lat: number;
  lng: number;
  rating: number;
  reviews: number;
  type: string;
}

type FacilityType = {
  id: string;
  label: string;
  Icon: React.ElementType;
  searchTerm: string;
};

// Define libraries array outside component
const libraries: ("places" | "geometry")[] = ["places", "geometry"];

// Define facility types outside component (as you already have)
const facilityTypes: FacilityType[] = [
  { id: 'hospital', label: 'Hospitals', Icon: Building2, searchTerm: 'hospital' },
  { id: 'pharmacy', label: 'Pharmacies', Icon: Pill, searchTerm: 'pharmacy' },
  { id: 'clinic', label: 'Walk-in Clinics', Icon: Stethoscope, searchTerm: 'walk_in_clinic' },
];

const sortOptions = [
  { id: 'distance', label: 'Distance' },
  { id: 'rating', label: 'Rating' },
  { id: 'reviews', label: 'Number of Reviews' },
];

const MapPage = () => {
  const [userLocation, setUserLocation] = useState({ lat: 43.6532, lng: -79.3832 });
  const [facilities, setFacilities] = useState<Facility[]>([]);
  const [selectedFacility, setSelectedFacility] = useState<Facility | null>(null);
  const [activeTypes, setActiveTypes] = useState(facilityTypes.map(t => t.id));
  const [radius, setRadius] = useState(5);
  const [sortBy, setSortBy] = useState('distance');
  const [loading, setLoading] = useState(true);
  const [selectedType, setSelectedType] = useState<string>('');
  const [containerHeight, setContainerHeight] = useState(0);

  // Add this ref to store the map instance
  // @ts-ignore
  const mapRef = React.useRef<google.maps.Map | null>(null);

  const { isLoaded } = useLoadScript({
    googleMapsApiKey: process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || '',
    libraries
  });

  useEffect(() => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          setUserLocation({
            lat: position.coords.latitude,
            lng: position.coords.longitude
          });
        },
        (error) => {
          console.error('Error getting location:', error.message);
          // Fallback to default location if geolocation fails
          setUserLocation({ lat: 43.6532, lng: -79.3832 }); // Toronto coordinates
        },
        {
          enableHighAccuracy: true,
          timeout: 5000,
          maximumAge: 0
        }
      );
    }
  }, []);

  useEffect(() => {
    if (userLocation.lat && userLocation.lng && isLoaded) {
      fetchNearbyFacilities(userLocation.lat, userLocation.lng);
    }
  }, [userLocation, activeTypes, radius, isLoaded]);

  useEffect(() => {
    if (facilities.length > 0) {
      const sortedFacilities = sortFacilities(facilities, sortBy, userLocation.lat, userLocation.lng);
      setFacilities(sortedFacilities);
    }
  }, [sortBy]);

  useEffect(() => {
    const listEl = document.getElementById('facilities-list');
    const filtersEl = document.querySelector('.p-4.space-y-4');
    
    if (listEl && filtersEl) {
      const totalHeight = (listEl as HTMLElement).offsetHeight + (filtersEl as HTMLElement).offsetHeight;
      setContainerHeight(totalHeight);
      
      const resizeObserver = new ResizeObserver((entries) => {
        const newTotalHeight = (listEl as HTMLElement).offsetHeight + (filtersEl as HTMLElement).offsetHeight;
        setContainerHeight(newTotalHeight);
      });
      
      resizeObserver.observe(listEl);
      resizeObserver.observe(filtersEl);
      
      return () => resizeObserver.disconnect();
    }
  }, [facilities, loading]);

  useEffect(() => {
    const logHeights = () => {
      const listEl = document.getElementById('facilities-list');
      const mapEl = document.getElementById('map-container');
      const filtersEl = document.querySelector('.p-4.space-y-4');  // Filters card
    };

    // Log immediately after render
    logHeights();

    // Log again after a short delay
    const timeoutId = setTimeout(logHeights, 500);

    // And after map loads
    if (mapRef.current) {
      logHeights();
    }

    return () => clearTimeout(timeoutId);
  }, [facilities, loading]);

  if (!isLoaded) return <div>Loading...</div>;

  const sortFacilities = (facilities: Facility[], sortBy: string, userLat: number, userLng: number) => {
    return [...facilities].sort((a, b) => {
      if (sortBy === 'distance') {
        // @ts-ignore
        const distA = google.maps.geometry.spherical.computeDistanceBetween(
          // @ts-ignore
          new google.maps.LatLng(userLat, userLng),
          // @ts-ignore
          new google.maps.LatLng(a.lat, a.lng)
        );
        // @ts-ignore
        const distB = google.maps.geometry.spherical.computeDistanceBetween(
          // @ts-ignore
          new google.maps.LatLng(userLat, userLng),
          // @ts-ignore
          new google.maps.LatLng(b.lat, b.lng)
        );
        return distA - distB;
      } else if (sortBy === 'rating') {
        return b.rating - a.rating;
      } else {
        return b.reviews - a.reviews;
      }
    });
  };

  const fetchNearbyFacilities = async (lat: number, lng: number) => {
    if (!isLoaded) {
      console.log("Maps not loaded yet");
      return;
    }
    setLoading(true);
    
    try {
      if (!mapRef.current) {
        console.log("Map reference not found");
        return;
      }

      // @ts-ignore
      const service = new window.google.maps.places.PlacesService(mapRef.current);

      // @ts-ignore
      const getAllResults = async (request: google.maps.places.PlaceSearchRequest) => {
        return new Promise((resolve) => {
          // @ts-ignore
          const allResults: google.maps.places.PlaceResult[] = [];
          
          // @ts-ignore
          const getNextPage = (
            results: google.maps.places.PlaceResult[] | null,
            status: google.maps.places.PlacesServiceStatus,
            pagination: google.maps.places.PlaceSearchPagination | null
          ) => {
            // @ts-ignore
            if (status === google.maps.places.PlacesServiceStatus.OK && results) {
              allResults.push(...results);
              
              if (pagination && pagination.hasNextPage) {
                setTimeout(() => {
                  pagination.nextPage();
                }, 2000);
              } else {
                resolve(allResults);
              }
            } else {
              resolve(allResults);
            }
          };

          service.nearbySearch(request, getNextPage);
        });
      };

      const requests = activeTypes.map(type => {
        const facilityType = facilityTypes.find(ft => ft.id === type);
        
        return getAllResults({
          location: { lat, lng },
          radius: radius * 1000,
          type: facilityType?.id === 'pharmacy' ? 'pharmacy' : 'hospital',
          keyword: facilityType?.id === 'clinic' ? 'walk in clinic' : undefined
        }).then(results => {
          return { type, results };
        });
      });

      // @ts-ignore
      const allResults = await Promise.all(requests) as Array<{ type: string; results: google.maps.places.PlaceResult[] }>;

      const combinedResults = allResults.flatMap(({ type, results }) => {
        return results.map(place => {
          const id = `${place.place_id}-${type}`;
          return {
            id,
            name: place.name!,
            address: place.vicinity!,
            lat: place.geometry!.location!.lat(),
            lng: place.geometry!.location!.lng(),
            rating: place.rating || 0,
            reviews: place.user_ratings_total || 0,
            type
          };
        });
      });

      // Remove any duplicates
      const uniqueResults = Array.from(
        new Map(combinedResults.map(item => [item.id, item])).values()
      );

      setFacilities(uniqueResults);
    } catch (error) {
      console.error('Error fetching facilities:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleGetDirections = (facility: Facility) => {
    window.open(
      `https://www.google.com/maps/dir/?api=1&destination=${facility.lat},${facility.lng}`,
      '_blank'
    );
  };

  const calculateDistance = (facilityLat: number, facilityLng: number) => {
    // @ts-ignore
    const distance = google.maps.geometry.spherical.computeDistanceBetween(
      // @ts-ignore
      new google.maps.LatLng(userLocation.lat, userLocation.lng),
      // @ts-ignore
      new google.maps.LatLng(facilityLat, facilityLng)
    );
    return (distance / 1000).toFixed(1); // Convert to km and round to 1 decimal
  };

  return (
    <main className="min-h-screen bg-background pt-20 lg:pb-0 pb-[calc(100vh-32rem)]">
      <div className="container mx-auto px-4 py-8">
        <div className="flex flex-col lg:flex-row gap-6 h-[calc(100vh-12rem)]">
          {/* Left side (Filters + List) */}
          <div className="w-full lg:w-1/3 flex flex-col gap-4">
            <Card className="p-4 space-y-4">
              <div className="flex justify-between items-center">
                <h2 className="text-xl font-semibold">Filters</h2>
                {activeTypes.length > 0 && (
                  <Button 
                    variant="ghost" 
                    size="sm" 
                    onClick={() => setActiveTypes([])}
                    className="text-muted-foreground hover:text-foreground"
                  >
                    <X className="h-4 w-4 mr-2" />
                    Clear Filters
                  </Button>
                )}
              </div>
              
              {facilityTypes.map(({ id, label, Icon }) => (
                <Button
                  key={id}
                  variant={activeTypes.includes(id) ? 'ghost' : 'outline'}
                  className={cn(
                    "w-full justify-between group",
                    activeTypes.includes(id)
                      ? "bg-gradient-to-r from-black to-black/60 text-white hover:from-black/90 hover:to-black/50"
                      : ""
                  )}
                  onClick={() => {
                    setActiveTypes(prev =>
                      prev.includes(id)
                        ? prev.filter(t => t !== id)
                        : [...prev, id]
                    );
                  }}
                >
                  <div className="flex items-center">
                    {Icon && <Icon className="mr-2 h-4 w-4" />}
                    {label}
                  </div>
                  {activeTypes.includes(id) && (
                    <div className="h-4 w-4 rounded-full bg-white/20 flex items-center justify-center">
                      <Check className="h-3 w-3" />
                    </div>
                  )}
                </Button>
              ))}

              <div className="space-y-2">
                <div className="flex justify-between items-center">
                  <label className="text-sm font-medium">Search Radius</label>
                  <span className="text-sm font-medium text-primary">{radius} km</span>
                </div>
                <Slider
                  value={[radius]}
                  // @ts-ignore
                  onValueChange={([value]) => setRadius(value)}
                  min={1}
                  max={50}
                  step={1}
                  className="my-4"
                />
              </div>

              <div className="space-y-2">
                <label className="text-sm font-medium">Sort Results By</label>
                <Select value={sortBy} onValueChange={setSortBy}>
                  <SelectTrigger className="w-full bg-background border-primary/20">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {sortOptions.map(option => (
                      <SelectItem key={option.id} value={option.id}>
                        {option.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </Card>

            {/* Mobile Map - Only shown between filters and list on mobile */}
            <div className="lg:hidden">
              <Card className="p-1 h-[300px]">
                <GoogleMap
                  mapContainerClassName="w-full h-full rounded-lg map-container"
                  center={userLocation}
                  zoom={13}
                  // @ts-ignore
                  onLoad={(map) => {
                    mapRef.current = map;
                  }}
                >
                  {/* User location marker */}
                  <Marker
                    key="user-location"
                    position={userLocation}
                    // @ts-ignore
                    icon={{
                      // @ts-ignore
                      path: window.google.maps.SymbolPath.CIRCLE,
                      scale: 8,
                      fillColor: "#4285F4",
                      fillOpacity: 1,
                      strokeColor: "#ffffff",
                      strokeWeight: 2,
                    }}
                  />

                  {/* Facility markers */}
                  {facilities.map(facility => (
                    <Marker
                      key={`${facility.id}-${facility.type}`}
                      position={{ lat: facility.lat, lng: facility.lng }}
                      onClick={() => setSelectedFacility(facility)}
                      // @ts-ignore
                      icon={{
                        url: 'https://maps.google.com/mapfiles/ms/icons/red-dot.png',
                        scaledSize: new window.google.maps.Size(25, 25)
                      }}
                    />
                  ))}

                  {/* Info window for selected facility */}
                  {selectedFacility && (
                    <InfoWindow
                      position={{ lat: selectedFacility.lat, lng: selectedFacility.lng }}
                      onCloseClick={() => setSelectedFacility(null)}
                      options={{
                        maxWidth: 300,
                        minWidth: 250,
                        disableAutoPan: false
                      }}
                    >
                      <div className="min-w-[250px] max-w-[300px]">
                        <h3 className="font-semibold text-lg leading-tight">
                          {selectedFacility.name}
                        </h3>
                        <div className="space-y-3 mt-2">
                          <p className="text-sm text-muted-foreground border-l-2 border-primary/20 pl-2">
                            {selectedFacility.address}
                          </p>
                          
                          <div className="flex items-center gap-3 bg-muted/50 rounded-md p-2">
                            <div className="flex items-center gap-1">
                              <Star className="h-4 w-4 text-yellow-400" />
                              <span className="text-sm font-medium">{selectedFacility.rating}</span>
                            </div>
                            <span className="text-sm text-muted-foreground">
                              ({selectedFacility.reviews} reviews)
                            </span>
                          </div>

                          <div className="flex items-center gap-2 text-muted-foreground">
                            <MapPin className="h-4 w-4" />
                            <span className="text-sm">
                              {calculateDistance(selectedFacility.lat, selectedFacility.lng)} km away
                            </span>
                          </div>

                          <Button
                            size="sm"
                            className="w-full bg-primary/90 hover:bg-primary"
                            onClick={() => handleGetDirections(selectedFacility)}
                          >
                            <Navigation className="h-4 w-4 mr-2" />
                            Get Directions
                          </Button>
                        </div>
                      </div>
                    </InfoWindow>
                  )}
                </GoogleMap>
              </Card>
            </div>

            {/* Facilities List */}
            <div 
              className="space-y-2 h-[calc(100vh-32rem)] overflow-y-auto"
              id="facilities-list"
            >
              {loading ? (
                <Card className="p-4">
                  <div className="flex items-center gap-2">
                    <Loader2 className="h-4 w-4 animate-spin" />
                    <span>Loading facilities...</span>
                  </div>
                </Card>
              ) : facilities.length === 0 ? (
                <Card className="p-4">No facilities found</Card>
              ) : (
                facilities.map(facility => (
                  <Card
                    key={`${facility.id}-${facility.type}`}
                    className="p-4 hover:shadow-md transition-shadow cursor-pointer"
                    onClick={() => setSelectedFacility(facility)}
                  >
                    <div className="flex justify-between items-start gap-4">
                      <div className="min-w-0 flex-1">
                        <h3 className="font-medium truncate">{facility.name}</h3>
                        <p className="text-sm text-muted-foreground truncate">{facility.address}</p>
                        <div className="flex items-center gap-2 mt-2 flex-wrap">
                          <div className="flex items-center gap-1">
                            <Star className="h-4 w-4 text-yellow-400 flex-shrink-0" />
                            <span className="text-sm">{facility.rating}</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <MessageSquare className="h-4 w-4 text-muted-foreground flex-shrink-0" />
                            <span className="text-sm">{facility.reviews}</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <MapPin className="h-4 w-4 text-blue-500 flex-shrink-0" />
                            <span className="text-sm">{calculateDistance(facility.lat, facility.lng)} km</span>
                          </div>
                        </div>
                      </div>
                      <Button
                        variant="ghost"
                        size="sm"
                        className="flex-shrink-0"
                        onClick={(e) => {
                          e.stopPropagation();
                          handleGetDirections(facility);
                        }}
                      >
                        <Navigation className="h-4 w-4 mr-2" />
                        Directions
                      </Button>
                    </div>
                  </Card>
                ))
              )}
            </div>
          </div>

          {/* Desktop Map View - Unchanged */}
          <Card 
            className="flex-1 p-1 hidden lg:block"
            id="map-container"
          >
            <GoogleMap
              mapContainerClassName="w-full h-full rounded-lg map-container"
              center={userLocation}
              zoom={13}
              // @ts-ignore
              onLoad={(map) => {
                mapRef.current = map;
              }}
            >
              {/* User location marker */}
              <Marker
                key="user-location"
                position={userLocation}
                // @ts-ignore
                icon={{
                  // @ts-ignore
                  path: window.google.maps.SymbolPath.CIRCLE,
                  scale: 8,
                  fillColor: "#4285F4",
                  fillOpacity: 1,
                  strokeColor: "#ffffff",
                  strokeWeight: 2,
                }}
              />

              {/* Facility markers */}
              {facilities.map(facility => (
                <Marker
                  key={`${facility.id}-${facility.type}`}
                  position={{ lat: facility.lat, lng: facility.lng }}
                  onClick={() => setSelectedFacility(facility)}
                  // @ts-ignore
                  icon={{
                    url: 'https://maps.google.com/mapfiles/ms/icons/red-dot.png',
                    scaledSize: new window.google.maps.Size(25, 25)
                  }}
                />
              ))}

              {/* Info window for selected facility */}
              {selectedFacility && (
                <InfoWindow
                  position={{ lat: selectedFacility.lat, lng: selectedFacility.lng }}
                  onCloseClick={() => setSelectedFacility(null)}
                  options={{
                    maxWidth: 300,
                    minWidth: 250,
                    disableAutoPan: false
                  }}
                >
                  <div className="min-w-[250px] max-w-[300px]">
                    <h3 className="font-semibold text-lg leading-tight">
                      {selectedFacility.name}
                    </h3>
                    <div className="space-y-3 mt-2">
                      <p className="text-sm text-muted-foreground border-l-2 border-primary/20 pl-2">
                        {selectedFacility.address}
                      </p>
                      
                      <div className="flex items-center gap-3 bg-muted/50 rounded-md p-2">
                        <div className="flex items-center gap-1">
                          <Star className="h-4 w-4 text-yellow-400" />
                          <span className="text-sm font-medium">{selectedFacility.rating}</span>
                        </div>
                        <span className="text-sm text-muted-foreground">
                          ({selectedFacility.reviews} reviews)
                        </span>
                      </div>

                      <div className="flex items-center gap-2 text-muted-foreground">
                        <MapPin className="h-4 w-4" />
                        <span className="text-sm">
                          {calculateDistance(selectedFacility.lat, selectedFacility.lng)} km away
                        </span>
                      </div>

                      <Button
                        size="sm"
                        className="w-full bg-primary/90 hover:bg-primary"
                        onClick={() => handleGetDirections(selectedFacility)}
                      >
                        <Navigation className="h-4 w-4 mr-2" />
                        Get Directions
                      </Button>
                    </div>
                  </div>
                </InfoWindow>
              )}
            </GoogleMap>
          </Card>
        </div>
      </div>
    </main>
  );
};

export default MapPage;