

// Connects to data-controller="map"
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array

  }

  connect() {
    console.log(this.apiKeyValue);
    ;
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    // add existing markers to the map
    this.addMarkersToMap();
    // fit map to markets
    this.fitMapToMarkers();
    //init tracking variables
    this.isTracking = false;
    this.path = [];
    this.pathLayer = null;

    //add a button to start and stop tracking
    this.addTrackingButton();

  }
// adds markers to map
  addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(this.map)
    });
  }
  // function to make the map focus on the markers
  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    console.log('markers value:', this.markersValue);
    this.markersValue.forEach(marker => {
      console.log('marker:', marker);  //calling the marker in console
      if (marker && marker.lng !== undefined && marker.lat !== undefined) {
        bounds.extend([marker.lng, marker.lat]);
      } else {
        console.error('invalid markers:', marker);
      }
    });
    if (!bounds.isEmpty()) {
      this.map.fitBounds(bounds, {padding: 70, maxZoom: 15, duration: 0});
    } else {
      console.warn('bounds are empty no fitting map to markers');
    }

  }
  // Add a new marker at the clicked location
  // addMarker(lngLat) {
  //   new mapboxgl.Marker()
  //     .setLngLat(lngLat)
  //     .addTo(this.map);

  //   //save the marker to the server or update your markers array
  //   console.log(`New marker added at ${lngLat.lng}, ${lngLat.lat}`);

  //     }
  addTrackingButton() {
    const button = document.createElement('button');
    button.textContent = 'Start tracking';
    button.classList.add('mapbox-ctrl', 'mapbox-ctrl-group');
    button.onclick = () => this.toggleTracking(button);
    this.map.addControl({
      onAdd:  () => {
        const container = document.createElement('div');
        container.className = 'mapboxgl-ctrl mapboxgl-ctrl-group';
        container.appendChild(button);
        return container;
      },
      onRemove: () => { }
    });
  } //toggle tracking state
  toggleTracking(button) {
    this.isTracking = !this.isTracking;
    button.textContent = this.isTracking ? 'stop tracking' : 'start tracking'

    if (this.isTracking) {
      this.startTracking();
    } else {
      this.stopTracking();
    }
  }
  // start tracking the walk
  startTracking() {
    this.path = [];
    console.log(this)
    this.watchID  = navigator.geolocation.watchPosition(position => {
      const {lat, lng} = position.coords;
      const coordinates = [lat, lng];
      this.path.push(coordinates);
      this.updatePathLayer();
    }, error => console.error(error), {
      enableHighAccuracy: true,
      maximumAge: 1000,
      timeout: 10000
    });
  }
//stop tracking
  stopTracking() {
    navigator.geolocation.clearWatch(this.watchID);
    this.savePath();
  }
  //update the path layer on the map
  updatePathLayer() {
    if (this.pathLayer) {
      this.map.removeLayer('path');
      this.map.removeSource('path');
    }
    this.map.addSource('path', {
      type: 'geojson',
      data: {
        type: 'Feature',
        geometry: {
          type: 'LineString',
          coordinates: this.path
        }
      }
    });
    this.map.addLayer({
      id: 'path',
      type: 'line',
      source: 'path',
      layout: { 'line-join': 'round', 'line-cap': 'round' },
      paint: { 'line-color': '#888', 'line-width': 6 }
    });


  }
  // Save the tracked path to the server
  savePath() {
    fetch('/walks', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ path: this.path })
    })
    .then(response => response.json())
    .then(data => console.log(`Walk saved with ID: ${data.id}`))
    .catch(error => console.error('Error:', error));

    }
  }
