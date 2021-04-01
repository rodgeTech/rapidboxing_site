import React from "react";
import { Formik, Field } from "formik";
import PropTypes from "prop-types";
import * as Yup from "yup";
import InputField from "../../../common/InputField";

const Form = ({ createDeposit }) => {
  return (
    <div>
      <Formik
        initialValues={{
          amount: 0,
        }}
        validationSchema={DepositSchema}
        onSubmit={(values, { setSubmitting, setFieldError }) => {
          createDeposit(values, setSubmitting, setFieldError);
        }}
      >
        {({ handleSubmit, isSubmitting }) => (
          <form onSubmit={handleSubmit}>
            <div className="form-group mb-5">
              <label htmlFor="depositAmount">Deposit Amount</label>
              <Field
                component={InputField}
                name="amount"
                className="form-control"
              />
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              className="btn btn-primary btn-md btn-block mt-4 mb-3"
            >
              Record Deposit
            </button>
          </form>
        )}
      </Formik>
    </div>
  );
};

Form.propTypes = {
  createDeposit: PropTypes.func.isRequired,
};

export default Form;
