import ActionCable from 'actioncable';

export default class ScavengerHuntApi {
  constructor(){
    this.cable = ActionCable.createConsumer('/cable');
    this.subscription = false;
  }

  findScavengerHunt = (id) => {
    return fetch(`/maps/${id}/`)
      .then(response => response.json())
  }
}
