import React from 'react';
import PropTypes from 'prop-types';
import { confirmAlert } from 'react-confirm-alert';


const StatusBtn = ({ currentStatus, statusesEnum, statuses, updateStatus }) => {
  if (currentStatus === 'out_for_delivery') return null;

  const submit = (index) => {
    confirmAlert({
      title: 'Confirm update',
      message: 'Are you sure you want to do this?',
      buttons: [
        {
          label: 'Yes',
          onClick: () => updateStatus(index)
        },
        {
          label: 'No',
        }
      ]
    });
  };

  return (
    <div className="dropdown">
      <button className="btn btn-success dropdown-toggle px-4" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Update Status
      </button>
      <div className="dropdown-menu">
        {statusesEnum.map((status, index) => (
          <a
            key={status}
            className={`dropdown-item ${statusesEnum.indexOf(currentStatus) >= index ? 'disabled' : ''}`}
            href="#"
            onClick={() => submit(index)}
          >
            {statuses[index]}
          </a>
        ))}
      </div>
    </div>
  )
}

StatusBtn.propTypes = {
  currentStatus: PropTypes.string.isRequired,
  statusesEnum: PropTypes.instanceOf(Array).isRequired,
  statuses: PropTypes.instanceOf(Array).isRequired,
  updateStatus: PropTypes.func.isRequired,
};

export default StatusBtn;