import React from "react";

import FlatTotalTable from "../../common/lineItem/FlatTotalTable";
import ShippingTotalTable from "../../common/lineItem/ShippingTotalTable";
import FeesTotalTable from "../../common/lineItem/FeesTotalTable";
import OverallTotalTable from "../../common/lineItem/OverallTotalTable";

const Calculated = ({ calculatedValues, selectedRate }) => (
  <div>
    <div className="bg-primary px-2">
      <h4 className="m-0 text-white">Flat Line Item Total</h4>
    </div>

    <FlatTotalTable
      quantity={calculatedValues.quantity}
      bzdPrice={calculatedValues.bzd_total}
      usdPrice={calculatedValues.usd_total}
    />

    <div className="bg-primary px-2">
      <h4 className="m-0 text-white">Shipping Total</h4>
    </div>

    <ShippingTotalTable
      shippingRateName={selectedRate.name}
      shippingRateMin={selectedRate.minOrderWeight}
      shippingRateMax={selectedRate.maxOrderWeight}
      shippingRateAmount={selectedRate.rateAmount}
      flatShippingTotal={calculatedValues.flat_shipping_total}
      extraPounds={calculatedValues.extra_pounds}
      additionalPoundsTotal={calculatedValues.additional_pounds_total}
      shippingTotal={calculatedValues.shipping_total}
    />

    <div className="bg-primary px-2">
      <h4 className="m-0 text-white">Fees Total</h4>
    </div>

    <FeesTotalTable
      tax={calculatedValues.tax_total}
      duty={calculatedValues.duty_total}
      serviceCharge={calculatedValues.service_charge_total}
      insurance={calculatedValues.insurance_total}
      localPickup={calculatedValues.local_pickup_total}
      feesTotal={calculatedValues.fees_total}
    />

    <OverallTotalTable overallTotal={calculatedValues.overall_total} />
  </div>
);

export default Calculated;
