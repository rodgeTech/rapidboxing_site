import React from 'react';
import { Formik, Field } from 'formik';
import * as Yup from 'yup';
import PropTypes from 'prop-types';
import AsyncSelect from 'react-select/async';

import InputField from '../../common/InputField';

const DraftSchema = Yup.object().shape({
  name: Yup.string().required("Name can't be empty"),
  email: Yup.string().email("Must be a valid email").required("Email can't be empty"),
  contactNumber: Yup.string().required("Contact number can't be empty"),
  address: Yup.string().required("Address can't be empty"),
});

const Form = ({
  createDraft,
  userOptions,
  selectedUser,
  selectUser,
}) => {
  return (
    <React.Fragment>
      <Formik
        enableReinitialize
        initialValues={{
          userId: selectedUser.hasOwnProperty('id') ? selectedUser.id : "",
          name: selectedUser.hasOwnProperty('name') ? selectedUser.name : "",
          contactNumber: "",
          email: selectedUser.hasOwnProperty('email') ? selectedUser.email : "",
          address: "",
        }}
        validationSchema={DraftSchema}
        onSubmit={(values, { setSubmitting, setFieldError }) => {
          createDraft(values, setSubmitting, setFieldError);
        }}
      >
        {({
          handleSubmit,
          isSubmitting,
          values,
          setFieldValue
        }) => (
            <form onSubmit={handleSubmit}>
              <h5 className="pb-2 pt-3 title-light">
                <strong>Draft for existing customer</strong>
              </h5>
              <div className="form-group border-bottom pb-5">
                <label htmlFor="link">Customer</label>
                <AsyncSelect
                  isClearable
                  loadOptions={userOptions}
                  onChange={(option) => {
                    if (option) {
                      selectUser(option.value)
                    } else {
                      selectUser("")
                    }
                  }}
                  placeholder="Select customer"
                />
              </div>
              <h5 className="pt-3 pb-2 title-light">
                <strong>Or draft for new customer</strong>
              </h5>
              <div className="form-group mb-">
                <label htmlFor="name">Full Name</label>
                <Field
                  component={InputField}
                  name="name"
                  className="form-control form-control-lg"
                  value={values.name || ''}
                  disabled={selectedUser.hasOwnProperty('name')}
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="name">Email</label>
                <Field
                  component={InputField}
                  name="email"
                  className="form-control form-control-lg"
                  type="email"
                  value={values.email || ''}
                  disabled={selectedUser.hasOwnProperty('email')}
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="name">Contact Number</label>
                <Field
                  component={InputField}
                  name="contactNumber"
                  className="form-control form-control-lg"
                  value={values.contactNumber || ''}
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="name">Address</label>
                <Field
                  component={InputField}
                  name="address"
                  className="form-control form-control-lg"
                  value={values.address || ''}
                />
              </div>

              <button
                type="submit"
                disabled={isSubmitting}
                className="btn btn-primary btn-md mt-4 mb-3 px-5"
              >
                Continue
                </button>
            </form>
          )}
      </Formik>
    </React.Fragment>
  )
}

Form.propTypes = {
  createDraft: PropTypes.func.isRequired
};

export default Form;