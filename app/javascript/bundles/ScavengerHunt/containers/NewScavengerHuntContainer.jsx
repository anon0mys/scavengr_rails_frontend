import React from 'react';
import { Provider } from 'mobx-react';
import ScavengerHuntStore from '../stores/ScavengerHuntStore';
import NewScavengerHunt from '../components/NewScavengerHunt';

export default (props, _railsContext) => {
  return (
    <Provider ScavengerHuntStore={ScavengerHuntStore}>
      <NewScavengerHunt {...props} />
    </Provider>
  );
};
