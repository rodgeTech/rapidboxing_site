import React from 'react';
import PropTypes from 'prop-types';

const CustomerInfo = ({ order }) => {
  return (
    <div className="card px-4 py-3">
      <h4 className="pb-2 mb-1">Customer Details</h4>
      <div style={{ fontSize: '1.15rem' }}>
        <div className="row">
          <div className="col-md-12">
            <div className="customer-info-row pb-2">
              {order.userId ? (
                <a href={`/admin/users/${order.userId}`} className="link text-primary">
                  <i className="far fa-user mr-2"></i> {order.name}
                </a>
              ) : (
                  <p className="m-0">
                    <i className="far fa-user mr-2"></i> {order.name}
                  </p>
                )}
            </div>
          </div>
        </div>
        <div className="row mt-1">
          <div className="col-md-12">
            <div className="customer-info-row py-2">
              <p className="m-0">
                <i className="far fa-envelope mr-2"></i> {order.email}
              </p>
            </div>
          </div>

        </div>
        <div className="row mt-1">
          <div className="col-md-12">
            <div className="customer-info-row py-2">
              <p className="m-0">
                <i className="fas fa-mobile-alt mr-3"></i> {order.contactNumber}
              </p>
            </div>
          </div>
        </div>
        <div className="row mt-1 py-2">
          <div className="col-md-12">
            <p className="m-0">
              <i className="far fa-map mr-2"></i> {order.address}
            </p>
          </div>
        </div>
      </div>
    </div >
  )
}

CustomerInfo.propTypes = {
  order: PropTypes.instanceOf(Object),
};

export default CustomerInfo;
