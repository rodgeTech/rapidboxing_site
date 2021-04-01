import React from "react";
import PropTypes from "prop-types";

const Customer = ({ order }) => {
  console.log(order);
  return (
    <div className="card px-4 py-4">
      <div className="title title-xs mb-3 border-bottom pb-2">Customer</div>
      <div className="row">
        <div className="col-md-12">
          {order.attributes.user_id ? (
            <a
              href={`/admin/users/${order.attributes.user_id}`}
              className="link text-secondary"
            >
              <span className="mr-1 text-muted">Name:</span>{" "}
              {order.attributes.name}
            </a>
          ) : (
            <p>
              <span className="mr-1 text-muted">Name:</span>
              {order.attributes.name}
            </p>
          )}
        </div>
      </div>
      <div className="row">
        <div className="col-md-12">
          <p>
            <span className="mr-1 text-muted">Email:</span>
            {order.attributes.email}
          </p>
        </div>
      </div>
      <div className="row">
        <div className="col-md-12">
          <p>
            <span className="mr-1 text-muted">Phone:</span>
            {order.attributes.contact_number}
          </p>
        </div>
      </div>
      <div className="row">
        <div className="col-md-12">
          <p>
            <span className="mr-1 text-muted">Address:</span>
            {order.attributes.address}
          </p>
        </div>
      </div>
    </div>
  );
};

Customer.propTypes = {
  order: PropTypes.instanceOf(Object),
};

export default Customer;
