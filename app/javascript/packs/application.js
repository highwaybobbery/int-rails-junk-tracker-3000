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

import React, { useState } from 'react';

const VehicleForm = (props) => {
  const {
    vehicle,
    formUrl,
    formMethod
  } = props;

  const [nickname, setNickname] = useState(vehicle.nickname || '')
  const [type, setType] = useState(vehicle.type || 'Sedan')
  const [mileage, setMileage] = useState(vehicle.mileage || 0)
  const defaultDoor = { type: 'normal' }
  const [doors, setDoors] = useState(vehicle.doors || [{...defaultDoor},{...defaultDoor},{...defaultDoor},{...defaultDoor}])
  const [engine, setEngine] = useState(vehicle.engine || { status: 'works' })
  const [seat, setSeat] = useState(vehicle.seat || { status: 'works' })

  const vehicleTypeOptions = {
    Sedan: {
      doorsAllowed: 4,
      doorsCanSlide: false,
      seats: 0,
    },
    Coupe: {
      doorsAllowed: 2,
      doorsCanSlide: false,
      seats: 0,
    },
    MiniVan: {
      doorsAllowed: 4,
      doorsCanSlide: true,
      seats: 0,
    },
    Motorcycle: {
      doorsAllowed: 0,
      doorsCanSlide: false,
      seats: 1,
    }
  }

  const handleSubmit = async (e) => {
    e.preventDefault();
    const data = { vehicle: { door_attributes: doors, engine_attributes: engine, id: vehicle.id, nickname, type, mileage } };

    const requestParams = {
      method: formMethod,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    }

    fetch(formUrl, requestParams)
      .then(response => {
        if (response.redirected) {
          window.location.href = response.url;
        }
      })
  };

  const handleDoorChange = (el) =>{
    const doorIndex = el.dataset.door_index
    let updatedDoors = doors;
    let existingDoor = updatedDoors[doorIndex];

    if(existingDoor === undefined) {
      updatedDoors[doorIndex] = { type: el.value };
    } else {
      existingDoor.type = el.value;
    }

    setDoors(updatedDoors);
  }

  const renderDoors = () => {
    const {doorsAllowed, doorsCanSlide} = vehicleTypeOptions[type];

    if(doorsAllowed > 0) {
      let doorOptions = [<option value="none" key={0}>None</option>, <option value="normal" key={1}>Normal</option>];
      if(doorsCanSlide) doorOptions.push(<option value="sliding" key={2}>Sliding</option>);

      let doorSelects = [];
      for(let i=0; i< doorsAllowed; i++) {
        let doorType = getDoorType(doors[i])
        if(!doorsCanSlide && doorType == 'sliding') { doorType = 'normal' }

        doorSelects.push(
          <select id="door" name="door" defaultValue={doorType} data-door_index={i} data-door_id={doors[i]?.id} key={i} onChange={e => handleDoorChange(e.target)}>{doorOptions}</select>
        )
      }
      return (
        <div id="doors" className="field">
          <label>Doors</label>
          { doorSelects }
        </div>
      )
    }
  }

  const getDoorType = (door) => {
    if(door === undefined) {
      return 'none'
    }else{
      return door.sliding ? 'sliding' : 'normal'
    }
  }

  const handleTypeChange = (e) => {
    setType(e.target.value)
  }

  const typeDisabled = () => {
    return vehicle.id != undefined
  }

  const renderEngine = () => {
    return (
      <div id="engine" className="field">
        <label>Engine</label>
        <select id="engine_status" defaultValue={engine.status} onChange={e => setEngine({status: e.target.value })}>
          <option value="works">Works</option>
          <option value="fixable">Fixable</option>
          <option value="junk">Junk</option>
        </select>
      </div>
    )
  }

  const renderSeat = () => {
    // Note: this only handles a single seat, bolo for changes requiring more!
    const { seats } = vehicleTypeOptions[type];
    if(seats === 0) { return }

    return (
      <div id="seat" className="field">
        <label>Seat</label>
        <select id="seat_status" defaultValue={seat.status} onChange={e => setSeat({status: e.target.value })}>
          <option value="works">Works</option>
          <option value="fixable">Fixable</option>
          <option value="junk">Junk</option>
        </select>
      </div>
    )
  }

  return (
    <form onSubmit={handleSubmit}>
      <div className="field">
        <label>Type</label>
        <select id="type" name="select" defaultValue={type} disabled={typeDisabled()} onChange={e => handleTypeChange(e)}>
          <option value="Sedan">Sedan</option>
          <option value="Coupe">Coupe</option>
          <option value="MiniVan">Mini-Van</option>
          <option value="Motorcycle">Motorcycle</option>
        </select>
      </div>

      <div className="field">
        <label>Nickname</label>
        <input id="nickname" type="text" name="nickname" value={nickname} onChange={e => setNickname(e.target.value)} />
      </div>

      <div className="field">
        <label>Mileage</label>
        <input id="mileage" type="number" min="0" max="1000000" name="mileage" value={mileage} onChange={e => setMileage(e.target.value)} />
      </div>

      { renderDoors() }
      { renderEngine() }
      { renderSeat() }
      <br/>
      <button>Submit</button>&nbsp;
      <a href="/"><button>Cancel</button></a>
    </form>
  );
};

const VehicleList = (props) => {
  const {
    vehicles,
  } = props;

  const handleDestroy = async (e) => {
    e.preventDefault();
    const vehicleId = e.target.dataset.vehicle_id;
    const requestParams = {
      method: 'delete',
    }

    fetch(`/vehicles/${vehicleId}`, requestParams)
      .then(response => {
        if (response.redirected) {
          window.location.href = response.url;
        }
      })
  };

  const vehicleTypeString = (type) => {
    return({ MiniVan: 'Mini-Van' }[type] || type)
  }


  return (<>
    <h1>Vehicles</h1>

    <table>
      <thead>
        <tr>
          <th>Type</th>
          <th>Nickname</th>
          <th>Registration ID</th>
          <th colSpan="3"></th>
        </tr>
      </thead>

      <tbody>
        {vehicles.map((vehicle) => (
          <tr key={vehicle.id}>
            <td>{vehicleTypeString(vehicle.type)}</td>
            <td>{vehicle.nickname}</td>
            <td>{vehicle.registration_id}</td>
            <td><a href={`/vehicles/${vehicle.id}/edit`}>Edit</a></td>
            <td><button type="button" data-vehicle_id={vehicle.id} onClick={ e => handleDestroy(e) }>Destroy</button></td>
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
