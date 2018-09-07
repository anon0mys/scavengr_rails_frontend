$(document).ready(() => {
  $(".delete-scavenger-hunt-point").unbind("click").on("click", deleteScavengerHuntPoint);
});

function deleteScavengerHuntPoint(event) {
  let scavengerHuntId = $(this).attr('scavenger_hunt_id')
  let pointId = $(this).attr('point_id')
  fetch('https://bde23565173445efa24d03df46b00ee1.us-east-1.aws.found.io:9243/points/_delete_by_query', {
      method: "POST",
      headers: {
        "Authorization": "Basic ZWxhc3RpYzpPbWtqaksyTm12MWwwaHR6MmpmanN0dTI=",
        "Content-Type": "application/json"
      },
      body: `{ "query": { "bool": { "must": { "match": { "_id": "${pointId}"  } } } } }`
  })
  .then(response => fetchPoints(response.json(), scavengerHuntId))
  .catch(error => console.log(error));
}

async function fetchPoints(response, scavengerHuntId) {
  await response
  fetch(`https://bde23565173445efa24d03df46b00ee1.us-east-1.aws.found.io:9243/points/_search`, {
      method: "POST",
      headers: {
        "Authorization": "Basic ZWxhc3RpYzpPbWtqaksyTm12MWwwaHR6MmpmanN0dTI=",
        "Content-Type": "application/json"
      },
      body: `{"query": {"bool": {"must": {"match": { "point.scavenger_hunt_id": "${scavengerHuntId}" } } } } }`
  })
  .then(response => {
    let points = response.json()
    populatePoints(points)
    displayFlashMessage();
  })
  .catch(error => console.log(error));
}

async function populatePoints(response) {
  let points = await response
  let results = points.hits.hits
  $('.points-container').html("")
  results.forEach(result => {
    $('.points-container').append(
       `<ul class="points-card">
          <div class="card-left">
            <li><b>Address:</b><br> ${result._source.point.address}</li>
              <li><b>Message:</b> ${result._source.point.message}</li>
              <li><b>Clue:</b> ${result._source.point.clue}</li>
            </div>
          <a class="edit-btn" data-method="get" href="#"><i class="fas fa-edit"></i></a>
          <a class="delete-btn delete-scavenger-hunt-point" rel="nofollow" data-method="delete" href="/scavenger_hunts/${result._source.point.scavenger_hunt_id}/points/${result._source.point.id}"><i class="fas fa-trash-alt"></i></a>
      </ul>`
      )
  })
  $(".delete-scavenger-hunt-point").unbind("click").on("click", deleteScavengerHuntPoint);
}

function displayFlashMessage() {
  $(".flash-message").html("<p>Successfully deleted point</p>");
  $(".flash-message").addClass("flash-success");
  setTimeout(clearFlashMessage, 2000);
}

function clearFlashMessage() {
  $(".flash-message").html("");
  $(".flash-message").removeClass("flash-success");
}
