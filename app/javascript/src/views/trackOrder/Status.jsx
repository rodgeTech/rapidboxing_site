import React from 'react';
import PropTypes from 'prop-types';

const Status = ({ statusesEnum, currentStatusEnum, statuses, trackingNumber, trackOrder }) => {
  const statusClassName = (index) => {

    if (currentStatusEnum === 'out_for_delivery' && statusesEnum.indexOf(currentStatusEnum) == index) {
      return 'status-final';
    } else if (statusesEnum.indexOf(currentStatusEnum) == index) {
      return 'status-current';
    }
    return statusesEnum.indexOf(currentStatusEnum) > index ? 'status-completed' : 'status-incomplete';
  }

  return (
    // <div className="track-order-container mb-3 pt-2 pb-3">
    //   <div className="mb-2 pb-4">
    //     <div className="title-light title-sm">Your Order Status</div>
    //     <p className="m-0 title-light">Tracking Number: <span className="title">{trackingNumber}</span></p>
    //   </div>
    //   {statusesEnum.map((status, index) => (
    //     <div
    //       key={status}
    //       className={`order-status ${statusClassName(index)}`}>
    //       <p>
    //         <i className={inconClassName(index)}></i>
    //         {statuses[index]}
    //       </p>
    //     </div>
    //   ))}
    // </div >

    <div id="timeline-content">
      <ul class="timeline">
        {statusesEnum.map((status, index) => (
          <li className={`event ${statusClassName(index)}`} data-date={statuses[index]}>
            <p>We are awaiting the first deposit</p>
          </li>
        ))}
      </ul>
    </div>
  )
}

Status.propTypes = {
  statusesEnum: PropTypes.instanceOf(Array).isRequired,
  currentStatusEnum: PropTypes.string.isRequired,
  statuses: PropTypes.instanceOf(Array).isRequired,
  trackingNumber: PropTypes.number.isRequired,
  trackOrder: PropTypes.func.isRequired,
};

export default Status;