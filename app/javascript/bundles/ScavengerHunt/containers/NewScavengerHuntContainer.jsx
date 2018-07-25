import React from 'react';
import { Provider } from 'mobx-react';
import ScavengerHuntStore from '../stores/ScavengerHuntStore.jsx';
import NewScavengerHunt from '../components/NewScavengerHunt.jsx';

export default (props, _railsContext) => {
  return (
    <Provider ScavengerHuntStore={ScavengerHuntStore}>
      <NewScavengerHunt {...props} />
    </Provider>
  );
};
