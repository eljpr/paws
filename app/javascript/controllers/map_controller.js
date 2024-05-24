

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
    this.starTime = null;
    this.endTime = null;

    //add a button to start and stop tracking
    this.addTrackingButton();
    //this.addLogContainer();
    //this.showPopup();

  }
  // addLogContainer() {
  //   if (!document.getElementById('logContainer')) {
  //     const logContainer = document.createElement('div');
  //     logContainer.id = 'logContainer';
  //     logContainer.style.position = 'fixed';
  //     logContainer.style.bottom = '0';
  //     logContainer.style.left = '0';
  //     logContainer.style.width = '100%';
  //     logContainer.style.maxHeight = '200px';
  //     logContainer.style.overflowY = 'auto';
  //     logContainer.style.backgroundColor = 'rgba(0, 0, 0, 0.7)';
  //     logContainer.style.color = 'white';
  //     logContainer.style.padding = '10px';
  //     logContainer.style.fontFamily = 'monospace';
  //     document.body.appendChild(logContainer);
  //     this.log('Log container added to the DOM');
  //   }
  // }
  // log(message) {
  //   const logContainer = document.getElementById('logContainer');
  //   const logMessage = document.createElement('div');
  //   logMessage.textContent = message;
  //   logContainer.appendChild(logMessage);
  //   logContainer.scrollTop = logContainer.scrollHeight;
  // }
// adds markers to map
  addMarkersToMap() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          console.log(` bazinga Latitude: ${latitude}, Longitude: ${longitude}`);

          new mapboxgl.Marker()
          .setLngLat([longitude, latitude])
          .addTo(this.map);
          //zoom in on the marker
          this.map.flyTo({
            center: [longitude, latitude],
            zoom:15, //adjustable
            essential:true
          })
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
    // Adjust the size of the button
    button.style.width = '120px';
    button.style.height = '100px';


    this.map.addControl({
      onAdd:  () => {
        const container = document.createElement('div');
        container.className = 'mapboxgl-ctrl mapboxgl-ctrl-group';
        container.style.textAlign = 'center'; // Center align the button
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
      this.starTime = new Date();
      console.log(this.starTime)
      alert("your walk in being tracked")
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
    this.log(`Path: ${JSON.stringify(this.path)}`);
    this.watchID  = navigator.geolocation.watchPosition(position => { // isnt doing shit atm
      const lat = position.coords.latitude
      const lng = position.coords.longitude
      const coordinates = [lat, lng];
      // this.path.push(coordinates);
      this.path.push([ lat, lng]);
      console.log("watch position coords: ",coordinates)
      this.log(`Watch position coords: ${JSON.stringify(coordinates)}`); // coordinates are empty ????
      this.updatePathLayer();
    }, error => console.error(error), {
      enableHighAccuracy: true,
      maximumAge: 1000,
      timeout: 1000
    });
  }
//stop tracking
  stopTracking() {
    navigator.geolocation.clearWatch(this.watchID);
    this.endTime = new Date();
    console.log(this.endTime)
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
    //this.pathLayer = true
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
      body: JSON.stringify({ path: this.path, start_time: this.starTime, end_time: this.endTime })
    })
    .then(response => response.json())
    .then(data => console.log(`Walk saved with ID: ${data.id}`))
    .catch(error => console.error('Error:', error));
    //const totalDistance = this.calculateTotalDistance(this.path);
    //console.log(`Total distance walked: ${totalDistance.toFixed(2)} km`)
    }

    showPopup(Walk) {
      //Create a div element for the popup
      console.log('showPopup function called');
      console.log('Walk ID:', Walk.id);
      console.log('Start Time:', Walk.start_time);
      console.log('End Time:', Walk.end_time);
      console.log('Distance:', Walk.distance);
      console.log('Pace:', Walk.pace);
      const popup = document.createElement('div');
      popup.classList.add('popup');
      //create content for popup
  //     const content = document.createElement('div');
  //     content.innerHTML =  `
  //     <h2>Last Walk</h2>
  //     <p>Walk ID: ${Walk.id}</p>
  //     <p>Start Time: ${Walk.start_time}</p>
  //     <p>End Time: ${Walk.end_time}</p>
  //     <p>Distance: ${Walk.distance}</p>
  //     <p>Pace: ${Walk.pace}</p>
  // `;  //add content to the popup
      popup.appendChild(content);

      //append popup  to the body
      document.body.appendChild(popup);
     // Close the popup after 5 seconds
    setTimeout(() => {
        document.body.removeChild(popup);
    }, 5000);
    const style = document.createElement('style');
        style.innerHTML = `
            .popup {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border: 1px solid #ccc;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                z-index: 9999;
            }

            .popup h2 {
                margin-top: 0;
            }

            .popup p {
                margin: 5px 0;
            }

            .tracking-button {
                position: fixed;
                top: 10px;
                left: 50%;
                transform: translateX(-50%);
            }
        `; document.head.appendChild(style);

    }

  }
