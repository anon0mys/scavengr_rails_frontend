import React from 'react';
import { observer, inject } from 'mobx-react';
import MapGL, {Marker} from 'react-map-gl';
import moment from 'moment';
// import MARKER_STYLE from '../markerStyle';

const token = process.env.MapboxAccessToken;

@inject('ScavengerHuntStore')

@observer
export default class ScavengerHuntStore extends React.Component {
  constructor() {
    super();

    this.state = {
      viewport: {
        latitude: 43.6532,
        longitude: -79.3832
      },
      settings: {

      }
    };
  }

  renderMarker = (checkin) => {
    return (
      <Marker key={checkin.captured_at} longitude={checkin.lon} latitude={checkin.lat} >
        <div className="station">
          <span>{moment(checkin.captured_at).format('MMMM Do YYYY, h:mm:ss a')}</span>
        </div>
      </Marker>
    );
  }

  onViewportChange = (viewport) => {
    this.setState({viewport});
  }

  viewport = () => {
    const {ScavengerHuntStore} = this.props;
    let latitude = 43.6532;
    let longitude = -79.3832;

    if (ScavengerHuntStore.checkin) {
      latitude = ScavengerHuntStore.checkin.lat;
      longitude = ScavengerHuntStore.checkin.lon;
    }

    return {
      ...this.state.viewport,
      latitude,
      longitude
    };
  }

  render() {
    const {ScavengerHuntStore} = this.props;
    const viewport = this.viewport();

    return (
      <MapGL
        {...viewport}
        {...this.state.settings}
        mapStyle="mapbox://styles/mapbox/dark-v9"
        onViewportChange={this.onViewportChange}
        mapboxApiAccessToken={token} >
        <style>{MARKER_STYLE}</style>
        { ScavengerHuntStore.checkins.map(this.renderMarker) }
      </MapGL>
    );
  }
}
