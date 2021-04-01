import React from 'react';
import PropTypes from 'prop-types';

const TextAreaField = ({
  field, // { name, value, onChange, onBlur }
  form: { touched, errors }, // also values, setXXXX, handleXXXX, dirty, isValid, status, etc.
  ...props
}) => (
    <div>
      <textarea {...field} {...props} />
      {touched[field.name] && errors[field.name] && <div className="error">{errors[field.name]}</div>}
    </div>
  );

TextAreaField.propTypes = {
  field: PropTypes.instanceOf(Object).isRequired,
  form: PropTypes.instanceOf(Object).isRequired
};

export default TextAreaField;
