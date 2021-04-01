import React from "react";
import { moneyFormat } from "../../utils/money";

import FlatTotalTable from "../../common/lineItem/FlatTotalTable";
import ShippingTotalTable from "../../common/lineItem/ShippingTotalTable";
import FeesTotalTable from "../../common/lineItem/FeesTotalTable";
import OverallTotalTable from "../../common/lineItem/OverallTotalTable";

const OrderItemDetails = ({ orderItem }) => (
  <React.Fragment>
    <div className="bg-primary px-2">
      <h4 className="m-0 text-white">Flat Line Item Total</h4>
    </div>

    <FlatTotalTable
      quantity={orderItem.attributes.quantity}
      usdPrice={orderItem.attributes.price}
      bzdPrice={orderItem.attributes.price_usd}
    />

    <div className="bg-primary px-2">
      <h4 className="m-0 text-white">Shipping Total</h4>
    </div>

    <ShippingTotalTable
      shippingRateName={orderItem.attributes.shipping_rate_name}
      shippingRateMin={orderItem.attributes.shipping_rate_min}
      shippingRateMax={orderItem.attributes.shipping_rate_max}
      shippingRateAmount={orderItem.attributes.shipping_rate_amount}
      flatShippingTotal={orderItem.attributes.flat_shipping_total}
      extraPounds={orderItem.attributes.extra_pounds}
      additionalPoundsTotal={orderItem.attributes.additional_pounds_total}
      shippingTotal={orderItem.attributes.shipping_total}
    />

    <div className="bg-primary px-2">
      <h4 className="m-0 text-white">Fees Total</h4>
    </div>

    <FeesTotalTable
      tax={orderItem.attributes.tax}
      duty={orderItem.attributes.duty}
      serviceCharge={orderItem.attributes.service_charge}
      insurance={orderItem.attributes.insurance}
      localPickup={orderItem.attributes.local_pickup}
      feesTotal={orderItem.attributes.fees_total}
    />

    <OverallTotalTable overallTotal={orderItem.attributes.overall_total} />
  </React.Fragment>
);

export default OrderItemDetails;
