import React from 'react';
import Modal from 'react-modal';
import PropTypes from 'prop-types';
import Form from './recordDeposit/Form';

const modalStyles = {
  content: {
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
    transform: 'translate(-50%, -50%)',
    display: 'block',
    width: '500px',
  }
};

Modal.setAppElement('#modal-root')

const RecordDeposit = ({ modalOpen, toggleModal, createDeposit }) => {
  return (
    <div>
      <Modal
        isOpen={modalOpen}
        onRequestClose={toggleModal}
        style={modalStyles}
      >
        <div className="title-light title-sm mb-3">Record Payment Deposit</div>
        <Form createDeposit={createDeposit} />
      </Modal>
    </div>
  )
}

RecordDeposit.propTypes = {
  modalOpen: PropTypes.bool.isRequired,
  toggleModal: PropTypes.func.isRequired,
  createDeposit: PropTypes.func.isRequired,
};

export default RecordDeposit;


