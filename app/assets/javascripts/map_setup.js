mapboxgl.accessToken = 'pk.eyJ1IjoiaWRlYWx0eXBpY2FsIiwiYSI6ImNqazBjcG1tZDA1ZjIzcHFsY3NzeDZjbGUifQ.TKZIYgbzt9g7HVfScLh2cg';
var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v9',
    center: [-79.4512, 43.6568],
    zoom: 13
});

var geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken
});

map.addControl(geocoder);

navigator.geolocation.getCurrentPosition(position => {
  let coords = [position.coords.longitude, position.coords.latitude]
  map.setCenter(coords)
})

// After the map style has loaded on the page, add a source layer and default
// styling for a single point.
map.on('load', function() {
    map.addSource('single-point', {
        "type": "geojson",
        "data": {
            "type": "FeatureCollection",
            "features": []
        }
    });

    map.addLayer({
        "id": "point",
        "source": "single-point",
        "type": "circle",
        "paint": {
            "circle-radius": 10,
            "circle-color": "#007cbf"
        }
    });

    // Listen for the `result` event from the MapboxGeocoder that is triggered when a user
    // makes a selection and add a symbol that matches the result.
    geocoder.on('result', function(ev) {
      let location = map.getSource('single-point').setData(ev.result.geometry);
      address = $('input[placeholder="Search"]').val();
      $('input[name="coordinates"]').val(location._data.coordinates);
      $('.address-field').val(address);
    });

    //Listen for a 'select' event on the map and add a marker to the map
    map.on('click', function(ev) {
      let coords = ev.lngLat.toArray()
      let location = map.getSource('single-point').setData({type: "Point", coordinates: coords});
      address = `Lat: ${coords[0].toFixed(3)}, Lng: ${coords[1].toFixed(3)}`;
      $('input[name="coordinates"]').val(location._data.coordinates);
      $('.address-field').val(address);
    });
});

$(document).ready(() => {
  $(".add-point-button").on("click", addPoint);
  $(".done-button").on("click", doneRedirect);
});

function doneRedirect(event) {
  event.preventDefault()
  if ('referrer' in document) {
    window.location = document.referrer;
  } else {
    window.history.back();
  }
}

function addPoint(event) {
  event.preventDefault()
  $(".flash-message").html("");
  $(".flash-message").removeClass("flash-success");
  $(".flash-message").removeClass("flash-failure");
  let url = window.location.pathname;
  let scavenger_hunt_id = url.split('/')[2];
  point = buildPoint(scavenger_hunt_id)
  fetch(`/scavenger_hunts/${scavenger_hunt_id}/points`, {
    method: 'POST',
    credentials: "same-origin",
    body: JSON.stringify(point)
  })
  .then(response => {
    if(response.ok) {
      return response.json()
    } else {
      throw new Error('Failed')
    }
  })
  .then((data) => {
    $(".flash-message").html("<p>Successfully added new point</p>");
    $(".flash-message").addClass("flash-success");
    $('input[name="clue"]').val("");
    $('input[name="message"]').val("");
    $('.address-field').val("");
    $('input[name="coordinates"]').val("");
    $('input[placeholder="Search"]').val("")
  })
  .catch(error => {
    $(".flash-message").html("<p>Failed to create point</p>")
    $(".flash-message").addClass("flash-failure");
  })
}

function buildPoint(scavenger_hunt_id) {
  return { point: {
      scavenger_hunt_id: scavenger_hunt_id,
      clue: $('input[name="clue"]').val(),
      message: $('input[name="message"]').val(),
      address: $('.address-field').val(),
      location: $('input[name="coordinates"]').val().split(',').map(coord => parseFloat(coord))
    }
  }
}
