import React from "react";
import { Field } from "formik";
import PropTypes from "prop-types";

const ShippingSelect = ({
  rates,
  fetchingRates,
  displayHint,
  displayLabel,
  selectedRateId,
  errors,
}) => {
  if (fetchingRates == true) return null;

  const type = rates[0].type;
  const hint = rates[0].type === "weight_shipping_rate" ? "weight" : "price";

  const range = (rate) => {
    let min = "";
    let max = "";

    if (type === "weight_shipping_rate") {
      min = `${rate.attributes.min_order_weight}lb`;
      max = `${rate.attributes.max_order_weight}lb`;
    } else {
      min = rate.attributes.min_order_price;
      max = rate.attributes.max_order_price;
    }

    return `${min} - ${max}`;
  };

  return (
    <div className="form-group">
      {displayLabel && <label htmlFor="quantity">Shipping Range</label>}
      <Field
        component="select"
        name="shippingRate"
        className="form-control border border-secondary"
        defaultValue={selectedRateId}
      >
        <option label="Select a shipping range"></option>
        {rates.map((rate) => (
          <option value={rate.id} key={rate.id}>
            {rate.attributes.name} - ({range(rate)}) ={" "}
            {rate.attributes.rate_amount}
          </option>
        ))}
      </Field>
      {errors.shippingRate && (
        <div className="error">{errors.shippingRate}</div>
      )}
      {displayHint && (
        <div>
          <small className="text-secondary">
            To get an estimation on checkout select the appropriate {hint} range
          </small>
        </div>
      )}
    </div>
  );
};

ShippingSelect.propTypes = {
  rates: PropTypes.instanceOf(Array).isRequired,
  displayHint: PropTypes.bool,
  displayLabel: PropTypes.bool,
  fetchingRates: PropTypes.bool,
  selectedRateId: PropTypes.string,
  errors: PropTypes.instanceOf(Object),
  touched: PropTypes.instanceOf(Object),
};

ShippingSelect.defaultProps = {
  rates: [],
  displayHint: true,
  displayLabel: true,
  fetchingRates: false,
  selectedRateId: "",
  errors: {},
};

export default ShippingSelect;
