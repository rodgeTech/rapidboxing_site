import React from "react";
import StatusBtn from "./details/StatusBtn";
import InvoiceBtn from "./details/InvoiceBtn";

const Details = ({
  order,
  hasInvoice,
  updateStatus,
  statusEnum,
  createInvoice,
  showInvoiceModal,
  archiveOrder,
}) => {
  return (
    <React.Fragment>
      <div className="row mb-4">
        <div className="col-md-7">
          <div>
            <span className="title title-md mr-3">
              Order #{order.attributes.tracking_number}
            </span>
            {order.attributes.created_at}
          </div>
          <button
            onClick={showInvoiceModal}
            className="btn btn-link text-secondary px-0"
          >
            <i className="fas fa-file-invoice"></i> View Invoice
          </button>
          {!order.attributes.archive && (
            <button
              onClick={archiveOrder}
              className="btn btn-link text-secondary ml-3"
            >
              <i className="fas fa-archive"></i> Archive Order
            </button>
          )}
        </div>

        {!order.attributes.invoice_emailed_at && (
          <InvoiceBtn createInvoice={createInvoice} hasInvoice={hasInvoice} />
        )}

        {order.attributes.invoice_emailed_at && (
          <div className="col-md-5 text-right">
            <StatusBtn
              statusesEnum={order.attributes.statuses_enum}
              statuses={order.attributes.statuses}
              currentStatus={statusEnum}
              updateStatus={updateStatus}
            />
          </div>
        )}
      </div>
    </React.Fragment>
  );
};

export default Details;
