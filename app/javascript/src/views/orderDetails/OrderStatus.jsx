import React from 'react';
import PropTypes from 'prop-types';

const OrderStatus = ({ statusesEnum, currentStatusEnum, statuses }) => {
  const statusClassName = (index) => {

    if (statusesEnum.indexOf(currentStatusEnum) == index) {
      return 'status-current';
    } else if (statusesEnum.indexOf(currentStatusEnum) > index) {
      return 'status-completed';
    }

    return 'status-incomplete'
  }

  const inconClassName = (index) => {
    if (statusesEnum.indexOf(currentStatusEnum) == index) {
      return 'far fa-dot-circle mr-1';
    } else if (statusesEnum.indexOf(currentStatusEnum) > index) {
      return 'fas fa-check-circle mr-1';
    } else {
      return 'far fa-circle mr-1';
    }
  }

  return (
    <div className="order-status mb-5">
      {statusesEnum.map((status, index) => (
        <div
          key={status}
          className={`status ${statusClassName(index)}`}>
          <p>
            <i className={inconClassName(index)}></i>
            {statuses[index]}
          </p>
        </div>
      ))}
    </div >
  )
}

OrderStatus.propTypes = {
  status: PropTypes.string.isRequired,
  currentStatusEnum: PropTypes.string.isRequired,
};

export default OrderStatus;
