import React from 'react';
import PropTypes from 'prop-types';

const DraftItems = ({ draftItems }) => {
  return (
    <div className="card px-4 py-3">
      <div className="row">
        <div className="col-md-7">
          <h4 className="m-0">Draft Items</h4>
        </div>
        <div className="col-md-5 text-right">
          <h4 className="m-0">{draftItems.length}</h4>
        </div>
      </div>

      {draftItems.map(draftItem => (
        <table
          className="table draft-items-table"
          style={{ tableLayout: 'fixed', wordWrap: 'break-word', fontSize: '1.15rem' }}
          key={draftItem.id}
        >
          <tbody>
            <tr>
              <th style={{ width: "35%" }}>Link</th>
              <td>
                <div className="text-truncate">
                  <p className="text-truncate m-0">
                    <a href={draftItem.link} className="link text-primary" target="_blank">
                      {draftItem.link}</a>
                  </p>
                </div>
              </td>
            </tr>
            <tr>
              <th>Quantity</th>
              <td>{draftItem.quantity}</td>
            </tr>
            <tr>
              <th>Price</th>
              <td>${draftItem.price}</td>
            </tr>
            <tr>
              <th>Shipping</th>
              <td className="pb-4">
                {draftItem.shippingRate.name}
                {draftItem.shippingRate.shippingRateType == 'price_shipping_rate' ? (
                  <p className="m-0">{draftItem.shippingRate.minOrderPrice} - {draftItem.shippingRate.maxOrderPrice}</p>
                ) : (
                    <p className="m-0">{draftItem.shippingRate.minOrderWeight} - {draftItem.shippingRate.maxOrderWeight}</p>
                  )}
              </td>
            </tr>
          </tbody>
        </table>
      ))}


    </div >
  )
}

DraftItems.propTypes = {
  draftItems: PropTypes.instanceOf(Object),
};

export default DraftItems;
