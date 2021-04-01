import React from "react";
import ReactModal from "react-modal";

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

ReactModal.setAppElement("#modal-root");

const Modal = ({ children, title, closeModal, isOpen, contentStyles }) => {
  const domEl = document.getElementById("modal-root");

  const styles = {
    content: {
      ...modalStyles.content,
      ...contentStyles,
    },
  };

  if (!domEl) return null;

  return (
    <div>
      <ReactModal
        onRequestClose={closeModal}
        isOpen={isOpen}
        style={styles}
        closeTimeoutMS={300}
      >
        <div className="generic-modal">
          <header>
            <div className="row">
              <div className="col-md-9">
                <h5 className="title-light">{title}</h5>
              </div>
              <div className="col-md-3 text-right">
                <button
                  onClick={closeModal}
                  className="btn btn-link p-0"
                  style={{ color: "#ccc", verticalAlign: "top" }}
                >
                  <i className="fas fa-times"></i>
                </button>
              </div>
            </div>
          </header>
          <div className="mt-3">{children}</div>
        </div>
      </ReactModal>
    </div>
  );
};

export default Modal;
