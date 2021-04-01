import React from 'react';
import ReactLoader from 'react-loader-spinner';
import PropTypes from 'prop-types';

const Loader = ({ styles }) => (
  <div className="text-center">
    <ReactLoader type="Grid" color="#00BFFF" height={45} width={45} style={{ ...styles }} />
  </div>
);

Loader.propTypes = {
  styles: PropTypes.instanceOf(Object)
};

Loader.defaultProps = {
  styles: {}
}


export default Loader;
