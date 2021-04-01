import React from "react";
import { Formik, Field } from "formik";
import * as Yup from "yup";
import PropTypes from "prop-types";
import InputField from "../../common/InputField";

const TrackingNumberSchema = Yup.object().shape({
  trackingNumber: Yup.number()
    .typeError("Must be a valid number")
    .required("Tracking number can't be empty."),
});

const Form = ({ trackOrder }) => {
  return (
    <React.Fragment>
      <div className="title title-md mb-4">Track Your Order</div>

      <Formik
        initialValues={{
          trackingNumber: "",
        }}
        validationSchema={TrackingNumberSchema}
        onSubmit={(values, { setSubmitting, setFieldError }) => {
          trackOrder(values, setSubmitting, setFieldError);
        }}
      >
        {({ handleSubmit, isSubmitting, values }) => (
          <form onSubmit={handleSubmit}>
            <div className="form-group mb-">
              <label htmlFor="trackingNumber">Tracking Number</label>
              <Field
                component={InputField}
                name="trackingNumber"
                className="form-control"
                placeholder="Enter your order tracking number"
                value={values.trackingNumber || ""}
              />
            </div>
            <button
              type="submit"
              disabled={isSubmitting}
              className="btn btn-primary btn-md btn-block mt-4 mb-3"
            >
              Continue
            </button>
          </form>
        )}
      </Formik>
    </React.Fragment>
  );
};

Form.propTypes = {
  trackOrder: PropTypes.func.isRequired,
};

export default Form;
