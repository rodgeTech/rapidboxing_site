import React, { useState } from "react";
import Modal from "react-modal";
import { Document, Page, pdfjs } from "react-pdf";
import PropTypes from "prop-types";

// `/admin/orders/${order.id}/invoice.pdf`
pdfjs.GlobalWorkerOptions.workerSrc = `//cdnjs.cloudflare.com/ajax/libs/pdf.js/${pdfjs.version}/pdf.worker.js`;

const modalStyles = {
  content: {
    top: "50%",
    left: "50%",
    right: "auto",
    bottom: "auto",
    marginRight: "-50%",
    transform: "translate(-50%, -50%)",
    display: "block",
    width: "700px",
    maxHeight: "100vh",
  },
};

Modal.setAppElement("#modal-root");

const Invoice = ({ modalOpen, toggleModal, pdfUrl }) => {
  const [numPages, setNumPages] = useState(null);
  const [pageNumber, setPgeNumber] = useState(1);

  const onDocumentLoadSuccess = ({ numPages }) => {
    setNumPages(numPages);
  };

  if (!modalOpen) return null;
  return (
    <div>
      <Modal
        isOpen={modalOpen}
        onRequestClose={toggleModal}
        style={modalStyles}
      >
        <Document file={pdfUrl} onLoadSuccess={onDocumentLoadSuccess}>
          <Page pageNumber={pageNumber} />
        </Document>
        <p>
          Page {pageNumber} of {numPages}
        </p>
      </Modal>
    </div>
  );
};

Invoice.propTypes = {
  modalOpen: PropTypes.bool.isRequired,
  toggleModal: PropTypes.func.isRequired,
  pdfUrl: PropTypes.string.isRequired,
};

export default Invoice;
