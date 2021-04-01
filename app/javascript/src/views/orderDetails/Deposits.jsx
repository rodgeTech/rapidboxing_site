import React from "react";
import PropTypes from "prop-types";

const Deposits = ({
  deposits,
  users,
  toggleModal,
  hasInvoice,
  deleteDeposit,
}) => {
  return (
    <div className="card px-4 py-4">
      <div className="border-bottom mb-3 pb-2">
        <div className="row">
          <div className="col-md-6">
            <div className="title title-xs">Deposits</div>
          </div>
          {hasInvoice && (
            <div className="col-md-6 text-right">
              <button
                className="btn btn-link link-primary p-0 m-0"
                onClick={toggleModal}
              >
                <i className="far fa-edit"></i>
              </button>
            </div>
          )}
        </div>
      </div>

      {deposits.length > 0 &&
        deposits.map((deposit) => (
          <div className="deposit-item py-2" key={deposit.id}>
            <div className="row">
              <div className="col-md-7">
                <p>{deposit.attributes.amount}</p>
              </div>
              <div className="col-md-5 text-right">
                <button
                  onClick={() => deleteDeposit(deposit.id)}
                  className="btn btn-link link-secondary p-0 m-0"
                >
                  <i className="far fa-trash-alt"></i>
                </button>
              </div>
            </div>
            <div className="row">
              <div className="col-md-12">
                <p className="text-truncate font-size-xs">
                  Recorded by{" "}
                  {
                    users.find(
                      (user) =>
                        user.attributes.id == deposit.attributes.recorded_by_id
                    ).attributes.name
                  }
                </p>
              </div>
            </div>
            <div className="row">
              <div className="col-md-12">
                <p className="text-truncate font-size-xs">
                  {deposit.attributes.created_at}
                </p>
              </div>
            </div>
          </div>
        ))}
    </div>
  );
};

Deposits.propTypes = {
  deposits: PropTypes.instanceOf(Array),
  users: PropTypes.instanceOf(Array),
  toggleModal: PropTypes.func,
  deleteDeposit: PropTypes.func,
};

Deposits.defaultProps = {
  deposits: [],
  users: [],
  toggleModal: () => {},
  deleteDeposit: () => {},
};

export default Deposits;
