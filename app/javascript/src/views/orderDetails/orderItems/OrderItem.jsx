import React from "react";

import { moneyFormat } from "../../../utils/money";

const OrderItem = ({
  orderItem,
  shippingRate,
  toggleModal,
  toggleItemDetailsModal,
  hasInvoice,
}) => {
  return (
    <tr key={orderItem.id}>
      <td>
        <div className="text-truncate mb-3">
          <a
            href={orderItem.attributes.link}
            className="link link-secondary"
            target="_blank"
          >
            {orderItem.attributes.link}
          </a>
        </div>
        {orderItem.attributes.details}
      </td>
      <td>{orderItem.attributes.quantity}</td>
      <td>{moneyFormat(orderItem.attributes.price)}</td>
      <td>{moneyFormat(orderItem.attributes.price_usd)}</td>
      <td className="text-right">
        <button
          className="btn btn-secondary"
          onClick={() => toggleItemDetailsModal(orderItem)}
          title="View full details"
        >
          <i className="fas fa-eye"></i> Details
        </button>
        {!hasInvoice && (
          <button
            className="btn btn-link"
            onClick={() => toggleModal(orderItem)}
          >
            <i className="far fa-edit"></i>
          </button>
        )}
      </td>
    </tr>
  );
};

export default OrderItem;
