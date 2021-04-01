import React from "react";
import { Formik, Field } from "formik";
import * as Yup from "yup";
import InputField from "../../common/InputField";
import TextAreaField from "../../common/TextAreaField";

const ContactSchema = Yup.object().shape({
  name: Yup.string().required("Name can't be empty"),
  email: Yup.string()
    .email("Must be a valid email")
    .required("Email can't be empty"),
  message: Yup.string().required("Message can't be empty"),
});

const Form = ({ submitMessage }) => {
  return (
    <React.Fragment>
      <Formik
        initialValues={{
          name: "",
          email: "",
          message: "",
        }}
        validationSchema={ContactSchema}
        onSubmit={(values, { setSubmitting, resetForm }) => {
          submitMessage(values, setSubmitting, resetForm);
        }}
      >
        {({ handleSubmit, isSubmitting, values }) => (
          <form onSubmit={handleSubmit}>
            <div className="form-group mb-">
              <label htmlFor="name">Name</label>
              <Field
                component={InputField}
                name="name"
                className="form-control form-control-lg"
              />
            </div>
            <div className="form-group mb-">
              <label htmlFor="email">Email</label>
              <Field
                component={InputField}
                name="email"
                className="form-control form-control-lg"
              />
            </div>

            <div className="form-group mb-">
              <label htmlFor="message">Message</label>
              <Field
                component={TextAreaField}
                name="message"
                className="form-control"
              />
            </div>
            <button
              type="submit"
              disabled={isSubmitting}
              className="btn btn-success btn-md mt-4 mb-3 px-4"
            >
              Send Message
            </button>
          </form>
        )}
      </Formik>
    </React.Fragment>
  );
};

export default Form;
