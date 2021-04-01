import React from "react";

import { moneyFormat } from "../../utils/money";

const OverallTotalTable = ({ overallTotal }) => (
  <table className="table table-dark">
    <tbody>
      <tr>
        <th>Overall Total</th>
        <td className="title text-success">
          {moneyFormat(overallTotal, "bzd")}
        </td>
      </tr>
    </tbody>
  </table>
);

export default OverallTotalTable;
