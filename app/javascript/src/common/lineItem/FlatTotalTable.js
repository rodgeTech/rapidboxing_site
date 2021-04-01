import React from "react";

import { moneyFormat } from "../../utils/money";

const FlatTotalTable = ({ quantity, bzdPrice, usdPrice }) => (
  <table className="table">
    <tbody>
      <tr>
        <th>Qty</th>
        <td>{quantity}</td>
      </tr>
      <tr>
        <th>USD Sub Total</th>
        <td>{moneyFormat(usdPrice, "usd")}</td>
      </tr>
      <tr>
        <th>BZD Sub Total</th>
        <td className="title">{moneyFormat(bzdPrice, "bzd")}</td>
      </tr>
    </tbody>
  </table>
);

export default FlatTotalTable;
