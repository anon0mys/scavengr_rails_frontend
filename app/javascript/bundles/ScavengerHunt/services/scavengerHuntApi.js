import ActionCable from 'actioncable';

export default class ScavengerHuntApi {
  constructor() {
    this.cable = ActionCable.createConsumer('/cable');
    this.subscription = false;
  }

  findScavengerHunt = (id) => {
    return fetch(`/maps/${id}`, { credentials: "same-origin" })
      .then(response => response.json())
  }

  subscribeScavengerHunt = (user_id, callback) => {
    this.subscription = this.cable.subscriptions.create({
      channel: "ScavengerHuntChannel",
      room: user_id
    }, {
      received: callback
    });
  }

  postCheckin = (user_id, lat, lon, captured_at) => {
    this.subscription.send({
      user_id,
      lat,
      lon,
      captured_at
    });
  }
}
