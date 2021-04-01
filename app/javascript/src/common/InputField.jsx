import React from 'react';
import PropTypes from 'prop-types';

const InputField = ({ field, form: { touched, errors }, ...props }) => (
  <div>
    <input type="text" {...field} {...props} />
    {touched[field.name] && errors[field.name] && <div className="error">{errors[field.name]}</div>}
  </div>
);

InputField.propTypes = {
  field: PropTypes.instanceOf(Object).isRequired,
  form: PropTypes.instanceOf(Object).isRequired
};

export default InputField;
