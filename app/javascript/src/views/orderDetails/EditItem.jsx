import React from "react";
import Modal from "react-modal";
import PropTypes from "prop-types";
import { Formik, Field } from "formik";
import * as Yup from "yup";
import InputField from "../../common/InputField";
import ShippingSelect from "../../common/ShippingSelect";

const modalStyles = {
  content: {
    top: "50%",
    left: "50%",
    right: "auto",
    bottom: "auto",
    marginRight: "-50%",
    transform: "translate(-50%, -50%)",
    display: "block",
    width: "500px",
  },
};

Modal.setAppElement("#modal-root");

const EditItemSchema = Yup.object().shape({
  price: Yup.number()
    .typeError("Must be a valid number")
    .min(0, "Price can't be less than 0")
    .required("Price must be at least 0"),
});

const EditItem = ({
  modalOpen,
  toggleModal,
  updateItem,
  orderItem,
  weightShippingRates,
}) => {
  if (!modalOpen) return null;
  return (
    <div>
      <Modal
        isOpen={modalOpen}
        onRequestClose={toggleModal}
        style={modalStyles}
      >
        <div className="title-light title-sm">Edit Order item</div>
        <Formik
          initialValues={{
            price: 0 || orderItem.attributes.price,
            quantity: orderItem.attributes.quantity || 0,
            extraPounds: orderItem.attributes.extra_pounds || 0,
            localPickup: orderItem.attributes.local_pickup,
          }}
          validationSchema={EditItemSchema}
          onSubmit={(values, { setSubmitting }) => {
            updateItem(values, setSubmitting);
          }}
        >
          {({ handleSubmit, isSubmitting, values }) => (
            <form onSubmit={handleSubmit}>
              <div className="border-top mt-4 pt-4">
                <div className="row">
                  <div className="col-md-3">
                    <h5>Price:</h5>
                  </div>
                  <div className="col-md-7 ml-auto">
                    <Field
                      component={InputField}
                      name="price"
                      className="form-control border-secondary"
                      type="number"
                    />
                  </div>
                </div>
              </div>

              <div className="row mt-3">
                <div className="col-md-3">
                  <h5>Quantity:</h5>
                </div>
                <div className="col-md-7 ml-auto">
                  <Field
                    component={InputField}
                    name="quantity"
                    className="form-control border-secondary"
                    type="number"
                  />
                </div>
              </div>

              <div className="row mt-3">
                <div className="col-md-3">
                  <h5>Shipping:</h5>
                </div>
                <div className="col-md-7 ml-auto">
                  {weightShippingRates.length > 0 && (
                    <div className="row">
                      <div className="col-md-12">
                        <small>Weight shipping rate</small>
                        <ShippingSelect
                          rates={weightShippingRates}
                          displayHint={false}
                          displayLabel={false}
                          selectedRateId={orderItem.attributes.shipping_rate_id}
                        />
                      </div>
                    </div>
                  )}
                </div>
              </div>
              <div className="row mt-2">
                <div className="col-md-3">
                  <h5>Add'l Lbs:</h5>
                </div>
                <div className="col-md-7 ml-auto">
                  <Field
                    component={InputField}
                    name="extraPounds"
                    className="form-control border-secondary"
                    type="number"
                  />
                </div>
              </div>
              <div className="row mt-3">
                <div className="col-md-3">
                  <h5>Local Pickup:</h5>
                </div>
                <div className="col-md-7 ml-auto">
                  <Field
                    name="localPickup"
                    render={({ field, form }) => {
                      return (
                        <input
                          type="checkbox"
                          checked={field.value}
                          {...field}
                        />
                      );
                    }}
                  />
                </div>
              </div>
              <div className="text-center border-top mt-3">
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="btn btn-primary px-5 mt-4 mb-3"
                >
                  Update
                </button>
              </div>
            </form>
          )}
        </Formik>
      </Modal>
    </div>
  );
};

EditItem.propTypes = {
  modalOpen: PropTypes.bool.isRequired,
  toggleModal: PropTypes.func.isRequired,
  updateItem: PropTypes.func.isRequired,
};

export default EditItem;
