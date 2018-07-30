import { observable, action } from 'mobx';
import ScavengerHuntApi from '../services/scavengerHuntApi';

class ScavengerHuntStore {
  @observable scavenger_hunt = {};
  @observable checkin = { pointsWithin: [], pointsOutside: []};

  constructor() {
    this.scavengerHuntApi = new ScavengerHuntApi();
  }

  @action findScavengerHunt = (id, userId) => {
    this.scavengerHuntApi.findScavengerHunt(id)
      .then(scavenger_hunt => {
        this.scavenger_hunt = scavenger_hunt;

        this.scavengerHuntApi.subscribeScavengerHunt(id, userId, checkin => {
          this.recordCheckin(checkin)
        });

        this.postCheckin();
      })
    };

  @action recordCheckin = (checkin) => {
    this.checkin = {
      pointsWithin: checkin.in_range,
      pointsOutside: checkin.outside_range,
      lat: parseFloat(checkin.lat),
      lon: parseFloat(checkin.lon),
      captured_at: parseInt(checkin.captured_at)
    };
  }

  @action postCheckin = () => {
    navigator.geolocation.getCurrentPosition(position => {
      this.scavengerHuntApi.postCheckin(
        this.scavenger_hunt.user_id,
        position.coords.latitude,
        position.coords.longitude,
        position.timestamp
      );

      setTimeout(() => {
        this.postCheckin();
      }, 50);
    });
  }
}

const store = new ScavengerHuntStore();
export default store;
