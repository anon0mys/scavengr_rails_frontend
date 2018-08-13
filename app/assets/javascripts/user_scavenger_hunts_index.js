$(document).ready(() => {
  $(".delete-user-scavenger-hunt").unbind("click").on("click", deleteUserScavengerHunt);
});

function deleteUserScavengerHunt(event) {
  event.preventDefault()
  let token = $(this).attr('token')
  let username = $(this).attr('username')
  let scavenger_hunt_id = $(this).attr('scavenger_hunt_id')
  fetch(`https://scavengr-django.herokuapp.com/api/v1/scavenger_hunts/${scavenger_hunt_id}`, {
      method: 'DELETE',
      headers: {
        "Authorization": `Token ${token}`
      }
  })
  .then(response => fetchUserScavengerHunts(username, token, response))
  .catch(error => console.log(error));
}

async function fetchUserScavengerHunts(username, token, response) {
  await response
  fetch(`https://scavengr-django.herokuapp.com/api/v1/users/${username}/scavenger_hunts/`, {
      method: 'GET',
      headers: {
        "Authorization": `Token ${token}`
      }
  })
  .then(response => {
    let scavengerHunts = response.json()
    populateUserScavengerHunts(username, token, scavengerHunts)
    displayFlashMessage();
  })
  .catch(error => console.log(error));
}

async function populateUserScavengerHunts(username, token, response) {
  let userScavengerHunts = await response
  $('.cards-container').html("")
  userScavengerHunts.forEach(hunt => {
    $('.cards-container').append(
       `<ul class='scavenger-hunt-card'>
          <a href=/${username}/scavenger_hunts/${hunt.id}>
            <div class='card-left'>
              <span class='card-title'>${hunt.name}</span>
              <li>Description: ${hunt.description}</li>
            </div>
          </a>
          <a class="edit-btn" data-method="get" href="/scavenger_hunts/${hunt.id}/edit"><i class="fas fa-edit"></i></a>
          <a class="delete-btn delete-user-scavenger-hunt" username=${username} token=${token} scavenger_hunt_id=${hunt.id} data-method="delete" href=`/scavenger_hunts/${hunt.id}`><i class="fas fa-trash-alt"></i></a>
        </ul>`
      )
  })
  $(".delete-user-scavenger-hunt").unbind("click").on("click", deleteUserScavengerHunt);
}

function displayFlashMessage() {
  $(".flash-message").html("<p>Successfully deleted scavenger hunt</p>");
  $(".flash-message").addClass("flash-success");
  setTimeout(clearFlashMessage, 2000);
}

function clearFlashMessage() {
  $(".flash-message").html("");
  $(".flash-message").removeClass("flash-success");
}
