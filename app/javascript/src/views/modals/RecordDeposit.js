import React from "react";
import { Formik, Field } from "formik";
import * as Yup from "yup";
import InputField from "../../common/InputField";

const DepositSchema = Yup.object().shape({
  amount: Yup.number()
    .typeError("Amount must be a valid number")
    .positive("Amount must be more than 0")
    .required("Amount can't be empty"),
});

const RecordDeposit = ({ createDeposit }) => {
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

export default RecordDeposit;
