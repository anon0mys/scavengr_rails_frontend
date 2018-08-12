$(document).ready(() => {
  $(".delete-current-scavenger-hunt").unbind("click").on("click", deleteCurrentScavengerHunt);
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
  .then(response => fetchCurrentScavengerHunts(username, token, response))
  .catch(error => console.log(error));
}

async function fetchCurrentScavengerHunts(username, token, response) {
  await response
  fetch(`https://scavengr-django.herokuapp.com/api/v1/current_scavenger_hunts/`, {
      method: 'GET',
      headers: {
        "Authorization": `Token ${token}`
      }
  })
  .then(response => {
    let scavengerHunts = response.json()
    populateCurrentScavengerHunts(username, token, scavengerHunts)
    displayFlashMessage();
  })
  .catch(error => console.log(error));
}

async function populateCurrentScavengerHunts(username, token, response) {
  let currentScavengerHunts = await response
  $('.cards-container').html("")
  currentScavengerHunts.forEach(hunt => {
    $('.cards-container').append(
       `<ul class='scavenger-hunt-card'>
          <a href=/${username}/scavenger_hunts/${hunt.scavenger_hunt_id}>
            <div class='card-left'>
              <span class='card-title'>${hunt.name}</span>
              <li>Creator: ${hunt.user_id}</li>
              <li>Description: ${hunt.description}</li>
            </div>
          </a>
          <a class="delete-btn delete-current-scavenger-hunt" username=${username} token=${token} scavenger_hunt_id=${hunt.scavenger_hunt_id} href=""><i class="fas fa-trash-alt"></i></a>
        </ul>`
      )
  })
  $(".delete-current-scavenger-hunt").unbind("click").on("click", deleteCurrentScavengerHunt);
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
