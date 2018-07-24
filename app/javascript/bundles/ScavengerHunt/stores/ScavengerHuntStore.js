import { observable, action } from 'mobx';
import ScavengerHuntApi from '../services/ScavengerHuntApi';

class ScavengerHuntStore {
  @observable scavenger_hunt = {};
  @observable checkin = {};

  constructor() {
    this.scavengerHuntApi = new ScavengerHuntApi();
  }

  @action findScavengerHunt = (id) => {
    this.scavengerHuntApi.findScavengerHunt(id).
      then(scavenger_hunt => {
        this.scavenger_hunt = scavenger_hunt;

        this.scavengerHuntApi.subscribeScavengerHunt(scavenger_hunt.user_id, checkin => {
          this.recordCheckin(checkin)
        });
      })
      //send location to the server
      this.postCheckin();
    });
  }
}

const store = new ScavengerHuntStore();
export default store;
