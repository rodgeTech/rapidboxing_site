import React from "react";
import { Formik, Field } from "formik";
import * as Yup from "yup";
import Select from "react-select";

import InputField from "../../common/InputField";

const CalculatorSchema = Yup.object().shape({
  price: Yup.number()
    .typeError("Must be a valid number")
    .min(1, "Price has to be greater than 0")
    .required("Price can't be blank"),
  quantity: Yup.number()
    .min(1, "Quantity can't be less than 1")
    .required("Quantity can't be empty"),
  shippingRate: Yup.object().shape({
    label: Yup.string().required("Shipping rate is required"),
    value: Yup.string().required(),
  }),
});

const Form = ({ calculate, fetchingRates, shippingRates, onSelectRate }) => {
  return (
    <React.Fragment>
      <Formik
        initialValues={{
          quantity: 1,
          price: "",
          shippingRate: {},
          extraPounds: 0,
          localPickup: false,
        }}
        validationSchema={CalculatorSchema}
        onSubmit={(values, { setSubmitting, setFieldError }) => {
          calculate(values, setSubmitting, setFieldError);
        }}
      >
        {({
          handleSubmit,
          isSubmitting,
          values,
          errors,
          touched,
          setFieldValue,
        }) => (
          <form onSubmit={handleSubmit}>
            <div className="form-group">
              <label htmlFor="price">USD Price</label>
              <Field
                type="number"
                component={InputField}
                name="price"
                className="form-control form-control-lg"
                value={values.price || ""}
              />
            </div>
            <div className="form-group">
              <label htmlFor="link">Quantity</label>
              <Field
                component={InputField}
                name="quantity"
                className="form-control form-control-lg"
                type="number"
                value={values.quantity || ""}
              />
            </div>
            <div className="form-group">
              <label htmlFor="link">Shipping Rate</label>
              <Select
                isLoading={fetchingRates}
                isClearable
                options={shippingRates}
                placeholder="Select shipping rate"
                value={
                  values.shippingRate.hasOwnProperty("value")
                    ? values.shippingRate
                    : ""
                }
                onChange={(option) => {
                  console.log(option);
                  if (option) {
                    onSelectRate(option.value);
                    setFieldValue("shippingRate", option);
                  } else {
                    setFieldValue("shippingRate", {});
                  }
                }}
              />
              {errors.shippingRate && touched.shippingRate && (
                <div className="error">{errors.shippingRate.label}</div>
              )}
            </div>

            <div className="form-group">
              <label htmlFor="price">Additional Pounds</label>
              <Field
                type="number"
                component={InputField}
                name="extraPounds"
                className="form-control form-control-lg"
                value={values.extraPounds || ""}
              />
            </div>

            <div className="form-group">
              <label
                htmlFor="localPickup"
                className="mr-2 mb-0"
                name="localPickup"
              >
                <Field
                  name="localPickup"
                  render={({ field, form }) => {
                    return (
                      <input type="checkbox" checked={field.value} {...field} />
                    );
                  }}
                />
                <span className="pl-2">Local Pickup</span>
              </label>
              <div>
                <small className="form-text text-muted">
                  Select this option only if the item you're ordering is within
                  the vicinity of our US location - Hialeah. This option only
                  applies for Walmart or Target purchases.
                </small>
              </div>
            </div>

            <button
              className="btn btn-primary btn-md mt-4 mb-3 px-5"
              disabled={isSubmitting}
              type="submit"
            >
              Calculate
            </button>
          </form>
        )}
      </Formik>
    </React.Fragment>
  );
};

export default Form;
