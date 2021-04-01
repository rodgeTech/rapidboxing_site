import React from "react";
import PropTypes from "prop-types";
import OrderItem from "./orderItems/OrderItem";

const OrderItems = ({
  orderItems,
  selectedShippingRates,
  toggleModal,
  toggleItemDetailsModal,
  hasInvoice,
}) => {
  const shippingRate = (orderItem) =>
    selectedShippingRates.find(
      (rate) => rate.attributes.id === orderItem.attributes.shipping_rate_id
    );

  return (
    <div className="admin-order-items mb-sm-5 mt-2">
      <div className="row">
        <div className="col-md-12">
          <table
            className="table table-striped table-responsive-sm"
            id="orders_table"
            style={{ tableLayout: "fixed", wordWrap: "break-word" }}
          >
            <thead className="title-light">
              <tr>
                <th style={{ width: "30%" }}>Details</th>
                <th>Qty</th>
                <th>USD</th>
                <th>BZD</th>
                <th style={{ width: "25%" }}></th>
              </tr>
            </thead>
            <tbody>
              {orderItems.map((orderItem) => (
                <OrderItem
                  key={orderItem.id}
                  orderItem={orderItem}
                  shippingRate={shippingRate(orderItem)}
                  toggleModal={toggleModal}
                  toggleItemDetailsModal={toggleItemDetailsModal}
                  hasInvoice={hasInvoice}
                />
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

OrderItems.propTypes = {
  orderItems: PropTypes.instanceOf(Object).isRequired,
};

export default OrderItems;
