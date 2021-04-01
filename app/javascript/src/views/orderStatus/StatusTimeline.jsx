import React from "react";
import PropTypes from "prop-types";

const StatusTimeline = ({
  statusesEnum,
  currentStatusEnum,
  statuses,
  trackingNumber,
  trackOrder,
}) => {
  const statusClassName = (index) => {
    if (
      currentStatusEnum === "out_for_delivery" &&
      statusesEnum.indexOf(currentStatusEnum) == index
    ) {
      return "status-final";
    } else if (statusesEnum.indexOf(currentStatusEnum) == index) {
      return "status-current";
    }
    return statusesEnum.indexOf(currentStatusEnum) > index
      ? "status-completed"
      : "status-incomplete";
  };

  const details = [
    "Awaiting first deposit to process order",
    "First deposit received, order is now being processed",
    "Order has arrived at our warehouse and is awaiting shipment",
    "Order has departed from our warehouse",
    "Order has arrived to our Belize warehouse",
    "Order has been dispatched to your location",
  ];

  return (
    <div id="timeline-content">
      <ul className="timeline">
        {statusesEnum.map((status, index) => (
          <li
            className={`event ${statusClassName(index)}`}
            data-date={statuses[index]}
            key={index}
          >
            <h6 className="title mobile-timeline-status">{statuses[index]}</h6>
            <p>{details[index]}</p>
          </li>
        ))}
      </ul>
    </div>
  );
};

StatusTimeline.propTypes = {
  statusesEnum: PropTypes.instanceOf(Array).isRequired,
  currentStatusEnum: PropTypes.string.isRequired,
  statuses: PropTypes.instanceOf(Array).isRequired,
  trackingNumber: PropTypes.number.isRequired,
  trackOrder: PropTypes.func.isRequired,
};

export default StatusTimeline;
