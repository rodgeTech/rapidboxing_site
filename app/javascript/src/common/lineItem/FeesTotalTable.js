import React from "react";

import { moneyFormat } from "../../utils/money";

const FeesTotalTable = ({
  tax,
  duty,
  serviceCharge,
  insurance,
  localPickup,
  feesTotal,
}) => (
  <table className="table">
    <tbody>
      <tr>
        <th>GST</th>
        <td>{moneyFormat(tax, "bzd")}</td>
      </tr>
      <tr>
        <th>Duty Rate</th>
        <td>{moneyFormat(duty, "bzd")}</td>
      </tr>
      <tr>
        <th>Service Charge</th>
        <td>{moneyFormat(serviceCharge, "bzd")}</td>
      </tr>
      <tr>
        <th>Insurance</th>
        <td>{moneyFormat(insurance, "bzd")}</td>
      </tr>
      <tr>
        <th>Local Pickup</th>
        <td>{moneyFormat(localPickup, "bzd")}</td>
      </tr>
      <tr>
        <th>Fees Total</th>
        <td className="title">{moneyFormat(feesTotal, "bzd")}</td>
      </tr>
    </tbody>
  </table>
);

export default FeesTotalTable;
