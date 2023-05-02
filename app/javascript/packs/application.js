// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import ReactOnRails from 'react-on-rails';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import React from 'react';

const VehicleForm = (props) => {
  const {
    vehicle,
  } = props;

  const handleSubmit = async (e) => {
    console.log(e);
  };

  return (
    <form onSubmit={handleSubmit}>
      <div className="field">
        <label>Nickname</label>
        <input id="nickname" type="text" name="nickname" />
      </div>
      <button>Submit</button>
    </form>
  );
};

const VehicleList = (props) => {
  const {
    vehicles,
  } = props;

  return (<>
    <h1>Vehicles</h1>

    <table>
      <thead>
        <tr>
          <th>Nickname</th>
          <th colSpan="3"></th>
        </tr>
      </thead>

      <tbody>
        {vehicles.map((vehicle) => (
          <tr key={vehicle.id}>
            <td>{vehicle.nickname}</td>
            <td><a href={`/vehicles/${vehicle.id}/edit`}>Edit</a></td>
            <td><button type="button">Destroy</button></td>
          </tr>
        ))}
      </tbody>
    </table>
    <a href="/vehicles/new">New Vehicle</a>
  </>);
}

ReactOnRails.register({
  VehicleList,
  VehicleForm,
});

