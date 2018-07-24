import { observable, action } from 'mobx';
import ScavengerHuntApi from '../services/ScavengerHuntApi';

class ScavengerHuntStore {
  @observable scavenger_hunt = {};

  constructor() {
    this.scavengerHuntApi = new ScavengerHuntApi();
  }
}

const store = new ScavengerHuntStore();
export default store;