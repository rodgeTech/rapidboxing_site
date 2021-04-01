import React from 'react';
import { Formik, Field } from 'formik';
import * as Yup from 'yup';
import PropTypes from 'prop-types';
import AsyncSelect from 'react-select/async';
import Select from 'react-select';

import InputField from '../../common/InputField';
import TextAreaField from '../../common/TextAreaField';


const DraftSchema = Yup.object().shape({
  link: Yup.string().url().required("Link can't be empty"),
  price: Yup.number().typeError("Must be a valid number")
    .min(1, "Price has to be greater than 0").
    required("Price can't be blank"),
  quantity: Yup.number()
    .min(1, "Quantity can't be less than 1")
    .required("Quantity can't be empty"),
  shippingRateId: Yup.string().required("You must select a shipping rate")
});

const Form = ({
  publishDraft,
  saveDraftItem,
  listingOptions,
  selectedListing,
  selectListing,
  fetchingShippingRates,
  shippingRates,
  selectedShippingRate,
  selectShippingRate,
  link,
  setLink,
  details,
  setDetails,
  price,
  setPrice,
  quantity,
  setQuantity
}) => {
  return (
    <React.Fragment>
      <Formik
        enableReinitialize
        initialValues={{
          details: details,
          quantity: quantity,
          price: selectedListing.hasOwnProperty('price') ? selectedListing.price : price,
          link: selectedListing.hasOwnProperty('link') ? selectedListing.link : link,
          details: details,
          listingId: selectedListing.hasOwnProperty('id') ? selectedListing.id : "",
          shippingRateId: selectedShippingRate.hasOwnProperty('value') ? selectedShippingRate.value : ""
        }}
        validationSchema={DraftSchema}
        onSubmit={(values, { setSubmitting, setFieldError }) => {
          saveDraftItem(values, setSubmitting, setFieldError)
        }}
      >
        {({
          handleSubmit,
          isSubmitting,
          values,
          setFieldValue,
          errors
        }) => (
            <form onSubmit={handleSubmit}>
              <div className="form-group">
                <label htmlFor="link">Listing</label>
                <AsyncSelect
                  isClearable
                  loadOptions={listingOptions}
                  onChange={(option) => {
                    if (option) {
                      selectListing(option.value)
                    } else {
                      selectListing("")
                    }
                  }}
                  placeholder="Select listing"
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="link">Link</label>
                <Field
                  component={TextAreaField}
                  name="link"
                  className="form-control"
                  value={values.link || ''}
                  disabled={Object.entries(selectedListing).length}
                  onChange={(e) => setLink(e.target.value)}
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="price">Price</label>
                <Field
                  component={InputField}
                  name="price"
                  className="form-control form-control-lg"
                  value={values.price || ''}
                  disabled={Object.entries(selectedListing).length}
                  onChange={(e) => setPrice(e.target.value)}
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="link">Details</label>
                <Field
                  component={TextAreaField}
                  name="details"
                  className="form-control"
                  value={values.details || ''}
                  onChange={(e) => setDetails(e.target.value)}
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="link">Quantity</label>
                <Field
                  component={InputField}
                  name="quantity"
                  className="form-control form-control-lg"
                  type="number"
                  value={values.quantity || ''}
                  onChange={(e) => setQuantity(e.target.value)}
                />
              </div>
              <div className="form-group mb-">
                <label htmlFor="link">Shipping Rate</label>
                <Select
                  isLoading={fetchingShippingRates}
                  isClearable
                  options={shippingRates}
                  placeholder="Select shipping rate"
                  onChange={(option) => {
                    if (option) {
                      selectShippingRate(option.value)
                    } else {
                      selectShippingRate("")
                    }
                  }}
                  isDisabled={Object.entries(selectedListing).length && Object.entries(selectedShippingRate).length > 0}
                  value={values.shippingRateId ? { label: selectedShippingRate.label, value: selectedShippingRate.value } : ""}
                />
                {errors['shippingRateId'] && <div className="error">{errors['shippingRateId']}</div>}
              </div>

              <button
                className="btn btn-primary btn-md mt-4 mb-3 px-5"
                disabled={isSubmitting}
                type='submit'
              >
                Save & Add More
              </button>
            </form>
          )}
      </Formik>
    </React.Fragment>
  )
}

Form.propTypes = {
  publishDraft: PropTypes.func.isRequired
};

export default Form;