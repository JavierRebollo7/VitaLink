// @ts-ignore
declare module '@react-google-maps/api';

// @ts-ignore
declare namespace google.maps {
  interface Map {}
  interface LatLng {}
  interface PlacesService {}
  interface PlaceResult {}
  interface PlaceSearchRequest {}
  interface PlaceSearchPagination {}
  interface PlacesServiceStatus {}
  interface SymbolPath {}
  interface Size {}
  interface Icon {}
}

// @ts-ignore
declare global {
  interface Window {
    google: typeof google;
  }
} 