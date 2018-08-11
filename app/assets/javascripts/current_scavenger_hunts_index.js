$(document).ready(() => {
  $(".delete-btn").on("click", deleteCurrentScavengerHunt);
});

function deleteCurrentScavengerHunt(event) {
  event.preventDefault()
  let token = $(this).attr('token')
  let username = $(this).attr('username')
  let scavenger_hunt_id = $(this).attr('scavenger_hunt_id')
  fetch(`https://scavengr-django.herokuapp.com/api/v1/current_scavenger_hunts/${scavenger_hunt_id}`, {
      method: 'DELETE',
      headers: {
        "Authorization": `Token ${token}`
      }
  })
  .then(response => fetchCurrentScavengerHunts(token, username, response))
  .catch(error => console.log(error));
}

async function fetchCurrentScavengerHunts(token, username, response) {
  await response
  fetch(`https://scavengr-django.herokuapp.com/api/v1/current_scavenger_hunts/`, {
      method: 'GET',
      headers: {
        "Authorization": `Token ${token}`
      }
  })
  .then(response => {
    let scavengerHunts = response.json()
    populateCurrentScavengerHunts(scavengerHunts)
  })
  .catch(error => console.log(error));
  displayFlashMessage();
}

function displayFlashMessage() {
  $(".flash-message").html("<p>Successfully removed scavenger hunt</p>");
  $(".flash-message").addClass("flash-message-success");
  setTimeout(clearFlashMessage, 2000);
}

function clearFlashMessage() {
  $(".flash-message").html("");
  $(".flash-message").removeClass("flash-message-success");
}

async function populateCurrentScavengerHunts(response) {
  let currentScavengerHunts = await response
  $('.cards-container').replaceWith("")
  currentScavengerHunts.forEach(hunt => {
    debugger
     $('.cards-container').append(
       `<ul class='scavenger-hunt-card'>
          <a href=/${hunt.username}/scavenger_hunts/${hunt.id}>
            <div class='card-left'>
              <span class='card-title'>${hunt.name}</span>
              <li>Description: ${hunt.description}</li>
            </div>
          </a>
        </ul>`
      )
  })
}
