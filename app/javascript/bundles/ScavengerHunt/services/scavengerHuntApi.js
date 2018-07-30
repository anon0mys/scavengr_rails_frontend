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

  subscribeScavengerHunt = (id, userId, callback) => {
    this.subscription = this.cable.subscriptions.create({
      channel: "ScavengerHuntChannel",
      userId: userId,
      scavengerHuntId: id
    }, {
      received: callback
    });
  }

  postCheckin = (userId, lat, lon, captured_at) => {
    this.subscription.send({
      userId,
      lat,
      lon,
      captured_at
    });
  }
}
