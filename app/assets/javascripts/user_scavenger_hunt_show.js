$(document).ready(() => {
  $(".delete-scavenger-hunt-point").unbind("click").on("click", deleteScavengerHuntPoint);
});

function deleteScavengerHuntPoint(event) {
  let pointId = $(this).attr('point_id')
  let scavengerHuntId = $(this).attr('scavenger_hunt_id')
  fetch(`localhost:9200/points/_delete_by_query`, {
      method: 'POST',
      headers: {
        "Content": "application/json"
      },
      body: `{ "query": { "bool": { "must": { "match": { "_id": ${pointId}  } } } } }`
  })
  .then(response => fetchPoints(scavengerHuntId))
  .catch(error => console.log(error));
}

async function fetchPoints(scavengerHuntId) {
  await response
  fetch(`localhost:9200/points/_search`, {
      method: 'POST',
      headers: {
        "Content": `application/json`
      },
      body: `{"query": {"bool": {"must": {"match_all": {}}}}}`
  })
  .then(response => {
    let response = response.json()
    populatePoints(response)
    displayFlashMessage();
  })
  .catch(error => console.log(error));
}

async function populatePoints(response) {
  let response = await response
  let results = response.hits.hits
  $('.cards-container').html("")
  results.forEach(result => {
    $('.cards-container').append(
       `<ul class="points-card">
          <div class="card-left">
            <li><b>Address:</b><br> ${result.source.point.address}</li>
              <li><b>Message:</b> ${result.source.point.message}</li>
              <li><b>Clue:</b> ${result.source.point.clue}</li>
            </div>
          <a class="edit-btn" data-method="get" href="#"><i class="fas fa-edit"></i></a>
          <a class="delete-btn delete-scavenger-hunt-point" rel="nofollow" data-method="delete" href="/scavenger_hunts/${result.source.point.scavenger_hunt_id}/points/${point.id}"><i class="fas fa-trash-alt"></i></a>
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
