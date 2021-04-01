import React from "react";
import PropTypes from "prop-types";
import { confirmAlert } from "react-confirm-alert";

const InvoiceBtn = ({ createInvoice }) => {
  const submit = () => {
    confirmAlert({
      title: "Email invoice",
      message: "Are you sure you want to do this?",
      buttons: [
        {
          label: "Yes",
          onClick: () => createInvoice(),
        },
        {
          label: "No",
        },
      ],
    });
  };

  return (
    <div className="col-md-5 col-12 text-sm-right pt-4 pt-sm-0">
      <button onClick={submit} className="btn btn-success px-4">
        <i className="fas fa-envelope mr-2"></i>
        Email Invoice
      </button>
    </div>
  );
};

InvoiceBtn.propTypes = {
  createInvoice: PropTypes.instanceOf(Function).isRequired,
};

export default InvoiceBtn;
