import React from "react";

import { moneyFormat } from "../../utils/money";

const ShippingTotalTable = ({
  shippingRateName,
  shippingRateMin,
  shippingRateMax,
  shippingRateAmount,
  flatShippingTotal,
  extraPounds,
  additionalPoundsTotal,
  shippingTotal,
}) => (
  <table className="table">
    <tbody>
      <tr>
        <th>Shipping Rate</th>
        <td>
          {shippingRateName}
          <br />
          {shippingRateMin}lb - {shippingRateMax}lb
          <br />
          {shippingRateAmount} USD
        </td>
      </tr>
      <tr>
        <th>Flat Shipping</th>
        <td>{moneyFormat(flatShippingTotal, "bzd")}</td>
      </tr>
      <tr>
        <th>Add'l Lbs {parseInt(extraPounds) > 0 && `(${extraPounds})`}</th>
        <td>{moneyFormat(additionalPoundsTotal, "bzd")}</td>
      </tr>
      <tr>
        <th>Shipping Total</th>
        <td className="title">{moneyFormat(shippingTotal, "bzd")}</td>
      </tr>
    </tbody>
  </table>
);

export default ShippingTotalTable;
