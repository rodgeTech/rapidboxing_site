import React from "react";
import PropTypes from "prop-types";

const Balance = ({ balance, total }) => {
  return (
    <div className="card px-4 py-4">
      <div className="title title-xs border-bottom mb-3 pb-2">Total</div>
      <h4>${total.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,")} BZD</h4>
      <div className="title title-xs border-bottom mb-3 mt-4 pb-2">Balance</div>
      <h4>
        <strong>
          ${balance.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, "$&,")} BZD
        </strong>
      </h4>
    </div>
  );
};

Balance.propTypes = {
  balance: PropTypes.number.isRequired,
  total: PropTypes.number.isRequired,
};

export default Balance;
