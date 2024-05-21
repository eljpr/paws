

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
    this.haversineDistance();
    this.calculateTotalDistance();

  }
// adds markers to map
  addMarkersToMap() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          console.log(` bazinga Latitude: ${latitude}, Longitude: ${longitude}`);

          new mapboxgl.Marker()
          .setLngLat([longitude, latitude])
          .addTo(this.map)
        },
        (error) => {
          console.error("Error getting location:", error);
        }
      );
    } else {
      console.log("Geolocation is not supported by this browser.");
    }
  };
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
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          console.log(`Latitude: ${latitude}, Longitude: ${longitude}`);
          this.path.push([ latitude, longitude]);
          this.updatePathLayer();
        },
        (error) => {
          console.error("Error getting location:", error);
        }
      );
    } else {
      console.log("Geolocation is not supported by this browser.");
    }
    //this.path = navigator.geolocation.getCurrentPosition(geolocation);  //[{"lat": 51.44901,"lng": -0.29155}];
    console.log(this.path)
    this.watchID  = navigator.geolocation.watchPosition(position => { // isnt doing shit atm
      const lat = position.coords.latitude
      const lng = position.coords.longitude
      const coordinates = [lat, lng];
      this.path.push(coordinates);
      console.log("watch position coords: ",coordinates) // coordinates are empty ????
      this.updatePathLayer();
    }, error => console.error(error), {
      enableHighAccuracy: true,
      maximumAge: 100,
      timeout: 1000
    });
  }
//stop tracking
  stopTracking() {
    navigator.geolocation.clearWatch(this.watchID);
    this.savePath();
  }
  //update the path layer on the map
  updatePathLayer() {
    if (this.map.getLayer('path')) {
      this.map.removeLayer('path');
    }
    if (this.map.getSource('route')) {
      this.map.removeSource('route');
    }

    this.map.addSource('route', {
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
      source: 'route',
      layout: { 'line-join': 'round', 'line-cap': 'round' },
      paint: { 'line-color': '#888', 'line-width': 6 }
    });
    //this.pathLayer = true;


  }
  // calculate the distance and speed using haversine formula
  // haversineDistance(coords1, coords2) {
  //   const toRad = (x) => x *Math.PI / 180;

  //   const lat1 = coords1[0];
  //   const lon1 = coords1[1];
  //   const lat2 = coords2[0];
  //   const lon2 = coords2[1];
  //   console.log(lat1, lon1, lat2, lon2)
  //   const R = 6371; // radius of earth ish
  //   const Dlat = toRad(lat2- lat1);
  //   const dlon = toRad(lon2 - lon1);
  //   const a = Math.sin(Dlat / 2) * Math.sin(dlat / 2) +
  //             Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
  //             Math.sin(dlon / 2) * Math.sin(dlon / 2);
  //   const c = 2 * Math.atan(Math.sqrt(a), Math.sqrt( 1 - a)); // stole this
  //   return R * c; //distance in km

  // }
  // calculateTotalDistance(path) {
  //   let totalDistance = 0;
  //   for (let i = 1; i < path.length; i++) {
  //     totalDistance += haversineDistance(path[i - 1], path[i]);
  //   }
  //   return totalDistance

  // }
  // Save the tracked path to the server
  savePath() {
    console.log(this.path)
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    console.log(token)
    fetch('/walks', {
      method: 'POST',
      headers: {
        'Accept':'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({ path: this.path })
    })
    .then(response => response.json())
    .then(data => console.log(`Walk saved with ID: ${data.id}`))
    .catch(error => console.error('Error:', error));
    //const totalDistance = this.calculateTotalDistance(this.path);
    //console.log(`Total distance walked: ${totalDistance.toFixed(2)} km`)
    }
  }
