import React from 'react';
import { observer, inject } from 'mobx-react';
import MapGL, {Marker} from 'react-map-gl';
import moment from 'moment';
import MARKER_STYLE from '../markerStyle';

const token = "pk.eyJ1IjoiaWRlYWx0eXBpY2FsIiwiYSI6ImNqazBjcG1tZDA1ZjIzcHFsY3NzeDZjbGUifQ.TKZIYgbzt9g7HVfScLh2cg";

@inject('ScavengerHuntStore')

@observer
export default class ScavengerHuntStore extends React.Component {
  constructor() {
    super();

    this.state = {
      viewport: {
        latitude: 39.7392,
        longitude: -104.9903,
        zoom: 16,
        bearing: 0,
        pitch: 0,
        width: window.innerWidth,
        height: window.innerHeight
      },
      settings: {
        dragPan: true,
        dragRotate: true,
        scrollZoom: true,
        touchZoomRotate: true,
        doubleClickZoom: true,
        minZoom: 0,
        maxZoom: 20,
        minPitch: 0,
        maxPitch: 85
      }
    };
  }

  renderMarker = (checkin) => {
    if (checkin.lat != undefined) {
      return (
        <Marker key={checkin.captured_at} longitude={checkin.lon} latitude={checkin.lat} >
        <div className="station marker-style">
          <span>Lat: {checkin.lat}<br/>
                Lon: {checkin.lon}
          </span>
        </div>
        </Marker>
      );
    } else {
      return (
        <Marker key="0" longitude="-104.9903" latitude="39.7392" >
          <div className="station marker-style">
            <span>Lat: -104.9903<br/>
                  Lon: 39.7392
            </span>
          </div>
        </Marker>
      );
    }
  }

  renderOutOfRange = (point) => {
    if (point.location != undefined) {
      return (
        <Marker key={point.location[0] * point.location[1]} longitude={point.location[0]} latitude={point.location[1]} >
        <div className="station out-of-range">
        <span>Clue: {point.clue}</span>
        </div>
        </Marker>
      );
    }
  }

  updatePoint = (point) => {
    fetch(`/user_points/${point.id}`, {
      method: "PATCH",
      credentials: "same-origin",
      body: JSON.stringify(point)
    })
  }

  renderWithinRange = (point) => {
    if (point.location != undefined) {
      return (
        <Marker key={point.location[0] * point.location[1]} longitude={point.location[0]} latitude={point.location[1]} >
        <div className="station within-range">
          <span>Clue: {point.clue}<br/>
                Address: {point.address}<br/>
                <button type="button" onClick={() => {this.updatePoint(point)}}>Found!</button>
          </span>
        </div>
        </Marker>
      );
    }
  }

  renderFound = (point) => {
    if (point.location != undefined) {
      return (
        <Marker key={point.location[0] * point.location[1]} longitude={point.location[0]} latitude={point.location[1]} >
        <div className="station found">
          <span>
            Clue: {point.clue}<br/>
            Message: {point.message}<br/>
            Address: {point.address}
          </span>
        </div>
        </Marker>
      );
    }
  }

  onViewportChange = (viewport) => {
    this.setState({viewport});
  }

  viewport = () => {
    const {ScavengerHuntStore} = this.props;
    // let latitude = 43.6532;
    // let longitude = -79.3832;
    //
    // if (ScavengerHuntStore.checkin.lat != undefined) {
    //   latitude = ScavengerHuntStore.checkin.lat;
    //   longitude = ScavengerHuntStore.checkin.lon;
    // }

    return {
      ...this.state.viewport
      // latitude,
      // longitude
    };
  }

  render() {
    const {ScavengerHuntStore} = this.props;
    const viewport = this.viewport();

    return (
      <MapGL
        {...viewport}
        {...this.state.settings}
        mapStyle="mapbox://styles/idealtypical/cjk33bhe12wnn2stfsbt36uzl"
        onViewportChange={this.onViewportChange}
        mapboxApiAccessToken={token} >
        <style>{MARKER_STYLE}</style>
        { ScavengerHuntStore.checkin.found.map(this.renderFound) }
        { ScavengerHuntStore.checkin.pointsOutside.map(this.renderOutOfRange) }
        { ScavengerHuntStore.checkin.pointsWithin.map(this.renderWithinRange) }
        { this.renderMarker(ScavengerHuntStore.checkin) }
      </MapGL>
    );
  }
}
