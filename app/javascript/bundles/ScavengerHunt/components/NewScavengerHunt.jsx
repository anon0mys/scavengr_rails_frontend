import React from 'react';
import ScavengerHuntForm from './ScavengerHuntForm';
import ScavengerHuntMap from './ScavengerHuntMap';

export default class NewScavengerHunt extends React.Component {
  render() {
    return (
      <div>
        <ScavengerHuntForm {...this.props} />
        <ScavengerHuntMap />
      </div>
    )
  }
}
