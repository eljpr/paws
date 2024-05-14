

// Connects to data-controller="map"
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,


  }

  connect() {
    console.log(this.apiKeyValue);
    ;
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });
    // add markers to map
    // this.addMarkersToMap();
    // // fit map to markets
    // this.fitMapToMarkers();
  }
// // adds markers to map
//   addMarkersToMap() {
//     this.markersValue.forEach((marker) => {
//       new mapboxgl.Marker()
//       .setLngLat([ marker.lng, marker.lat ])
//       .addTo(this.map)
//     });
//   }
//   fitMapToMarkers() {
//     const bounds = new mapboxgl.LngLatBounds();
//     this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]));
//     this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
//   }
// }
}
