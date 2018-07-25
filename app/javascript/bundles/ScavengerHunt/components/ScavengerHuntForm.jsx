import React from 'react';
import { observer, inject } from 'mobx-react';

// Inject the ScavengerHuntStore into our component as a prop.
@inject('ScavengerHuntStore')
// Make our class "react" (re-render) to store changes.
@observer
export default class ScavengerHuntForm extends React.Component {
  // When user submits form, call the `createScavengerHunt` action, passing the name.
  handleSubmit = (e) => {
    e.preventDefault();
    const url = window.location.pathname;
    const id = url.substring(url.lastIndexOf('/') + 1);
    this.props.ScavengerHuntStore.findScavengerHunt(id);
  }

  render() {
    const {ScavengerHuntStore} = this.props;

    // If we already have a scavenger_hunt in our store, display a link that can be
    // shared with anyone you want to share your realtime location with.
    if (ScavengerHuntStore.scavenger_hunt.name) {
      // const scavenger_hunt_url = `${window.location.protocol}`//${window.location.host}/scavenger_hunts/${ScavengerHuntStore.scavenger_hunt.id}`;

      return (
        <section className="scavenger_hunt-form-container">
          <p>
            Joined <strong>{ScavengerHuntStore.scavenger_hunt.name}</strong>
          </p>
        </section>
      )
    }

    // Display the form allowing user to create a new ScavengerHunt for themselves
    return (
      <section className="scavenger_hunt-form-container">
        <form onSubmit={e => this.handleSubmit(e)}>
          <button type="submit">Start Tracking</button>
        </form>
      </section>
    )
  }
}
