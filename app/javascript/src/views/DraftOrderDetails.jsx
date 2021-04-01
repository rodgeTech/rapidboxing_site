import React, { useReducer, useEffect, useState } from 'react';
import ReactDOM from 'react-dom';
import normalize from 'json-api-normalizer';
import build from 'redux-object';
import axios from '../utils/axios';

import CustomerInfo from './draftOrderDetails/CustomerInfo';
import DraftItems from './draftOrderDetails/DraftItems';
import Form from './draftOrderDetails/Form';


const initialState = {
  order: {},
  gettingOrder: true,

  orderItems: [],
  fetchingOrderItems: true,

  fetchingListings: true,
  listings: {},
  selectedListing: {},

  fetchingWeightShippingRates: true,
  weightShippingRates: [],

  fetchingPriceShippingRates: true,
  priceShippingRates: [],

  fetchingShippingRates: true,
  shippingRates: {},
  selectedShippingRate: {},
};

const reducer = (state, action) => {
  switch (action.type) {
    case 'GET_ORDER_SUCCESS': {
      const { order } = action;
      return {
        ...state,
        order,
        gettingOrder: false,
      };
    }
    case 'GET_ORDER_FAILURE':
      return { ...state, gettingOrder: false };
    case 'GET_ORDER_ITEMS_SUCCESS': {
      const { orderItems } = action;
      return {
        ...state,
        orderItems,
        fetchingOrderItems: false,
      };
    }
    case 'GET_LISTINGS_SUCCESS': {
      const {
        listings,
      } = action;
      return {
        ...state,
        listings,
        fetchingListings: false,
      };
    }
    case 'GET_WEIGHT_SHIPPING_RATES_SUCCESS': {
      const {
        weightShippingRates,
      } = action;
      return {
        ...state,
        weightShippingRates,
        fetchingWeightShippingRates: false,
      };
    }
    case 'GET_PRICE_SHIPPING_RATES_SUCCESS': {
      const {
        priceShippingRates,
      } = action;
      return {
        ...state,
        priceShippingRates,
        fetchingPriceShippingRates: false,
      };
    }
    case 'GET_SHIPPING_RATES_SUCCESS': {
      const {
        shippingRates,
      } = action;
      return {
        ...state,
        shippingRates,
        fetchingShippingRates: false,
      };
    }
    case 'SELECT_LISTING': {
      const {
        selectedListing,
      } = action;
      return {
        ...state,
        selectedListing,
      };
    }
    case 'SELECT_SHIPPING_RATE': {
      const {
        selectedShippingRate,
      } = action;
      return {
        ...state,
        selectedShippingRate,
      };
    }
    case 'GET_LISTINGS_FAILURE':
      return { ...state, listings: {}, shippingRates: {}, fetchingListings: false };
    default:
      return state;
  }
};

const DraftOrderDetails = ({ orderId }) => {
  const [state, dispatch] = useReducer(reducer, initialState);
  const [link, setLink] = useState('');
  const [price, setPrice] = useState('');
  const [details, setDetails] = useState('');
  const [quantity, setQuantity] = useState(1);
  const [errors, setErrors] = useState([]);


  useEffect(() => {
    axios
      .get(`orders/drafts/${orderId}`)
      .then(({ data }) => {
        const order = normalize(data, { endpoint: '/orders' });
        dispatch({ type: 'GET_ORDER_SUCCESS', order });
      })
      .catch(() => {
        dispatch({ type: 'GET_ORDER_FAILURE' });
      });
  }, []);

  useEffect(() => {
    axios
      .get(`orders/drafts/${orderId}/draft_items`)
      .then(({ data }) => {
        const orderItemsData = normalize(data, { endpoint: '/draft_items' });

        const orderItems = build(orderItemsData, 'orderItem', null);

        dispatch({ type: 'GET_ORDER_ITEMS_SUCCESS', orderItems });
      })
      .catch(() => {
        // dispatch('GET_ORDER_FAILURE');
      });
  }, []);

  useEffect(() => {
    axios
      .get('settings/shipping_rates?all=true')
      .then(({ data }) => {
        const shippingRatesData = normalize(data, { endpoint: '/shipping_rates' });
        const shippingRates = build(shippingRatesData, 'shippingRate', null);
        const rates = shippingRates.map(rate => ({ value: rate.id, label: ` ${rate.name} ${rate.minOrderPrice} - ${rate.maxOrderPrice}` }))

        dispatch({ type: 'GET_SHIPPING_RATES_SUCCESS', shippingRates: rates });
      })
      .catch(() => {
        // dispatch('GET_ORDER_FAILURE');
      });
  }, []);

  const loadListings = (inputValue) => {
    return axios
      .get(`listings?query=${inputValue}`)
      .then(({ data }) => {
        if (data.data.length) {

          const listingsData = normalize(data, { endpoint: '/listings' });

          dispatch({
            type: 'GET_LISTINGS_SUCCESS',
            listings: listingsData,
          });

          const listingsBuild = build(listingsData, 'listing', null);

          const listings = listingsBuild.map(listing => ({ value: listing.id, label: `${listing.title} $${listing.price}` }))
          return listings;
        }
      })
      .catch(({ response }) => {
        console.log(response)
      });
  };

  const listingOptions = inputValue =>
    new Promise(resolve => {
      setTimeout(() => {
        resolve(loadListings(inputValue));
      }, 500);
    });

  const selectListing = listingId => {
    if (listingId) {
      const listings = build(state.listings, 'listing', null);
      const selectedListing = listings.find(x => x.id === listingId)
      dispatch({ type: 'SELECT_LISTING', selectedListing });

      const selectedShippingRate = state.shippingRates.find(x => x.value === selectedListing.shippingRateId)
      dispatch({ type: 'SELECT_SHIPPING_RATE', selectedShippingRate });
    } else {
      const selectedListing = {}
      const selectedShippingRate = {}

      dispatch({ type: 'SELECT_LISTING', selectedListing });
      dispatch({ type: 'SELECT_SHIPPING_RATE', selectedShippingRate });
    }
  }

  const selectShippingRate = shippingRateId => {
    if (shippingRateId) {
      const selectedShippingRate = state.shippingRates.find(x => x.value === shippingRateId)

      dispatch({ type: 'SELECT_SHIPPING_RATE', selectedShippingRate });
    } else {
      const selectedShippingRate = {}
      dispatch({ type: 'SELECT_SHIPPING_RATE', selectedShippingRate });
    }
  }

  const publishDraft = () => {
    axios
      .patch(`orders/drafts/${orderId}/publish`)
      .then(res => {
        window.location.href = '/admin'
      })
      .catch(({ response }) => {
        setErrors([response.data.errors])
      });
  }

  const saveDraftItem = (values, setSubmitting, setFieldError) => {
    const order = build(state.order, 'order', null);

    const params = {
      order_id: order[0].id,
      link: values.link,
      price: values.price,
      details: values.details,
      quantity: values.quantity,
      shipping_rate_id: values.shippingRateId,
      // ...(values.listingId && { listing_id: values.listingId })
    }
    axios
      .post('orders/draft_items', params)
      .then(res => {
        window.location.reload();
      })
      .catch(({ response }) => {
        setSubmitting(false);
        // setFieldError('amount', response.data.errors[0]);
      });
  }

  const deleteDraft = () => {
    axios
      .delete(`orders/drafts/${orderId}`)
      .then(res => {
        window.location.href = '/admin/orders/drafts'
      })
      .catch(({ response }) => {
        // setErrors([response.data.errors])
      });
  }

  const {
    gettingOrder,
    order,
    fetchingOrderItems,
    orderItems,
    selectedListing,
    shippingRates,
    fetchingShippingRates,
    selectedShippingRate
  } = state;

  const orderDetails = build(order, 'order', null);

  return (
    <div className="container mb-5">
      <div className="row">
        <div className="col-md-7">
          <div className="row mb-3">
            <div className="col-md-6">
              <div className="title title-md">Draft Order Items</div>
            </div>
            <div className="col-md-6 text-right">
              <button
                className="btn btn-success mr-3 px-4 "
                onClick={publishDraft}
              >
                <i className="fas fa-check"></i> Publish
              </button>
              <button
                className="btn bg-white border text-danger"
                onClick={deleteDraft}
                onClick={() => { if (window.confirm('Are you sure to delete this draft?')) { deleteDraft() }; }}
              >
                <i className="far fa-trash-alt"></i> Delete
              </button>
            </div>
          </div>
          {errors.length > 0 &&
            <div className="row mb-3">
              <div className="col-md-12 text-danger">
                {errors[0]}
              </div>
            </div>
          }
          <div className="row">
            <div className="col-md-12">
              <Form
                publishDraft={publishDraft}
                saveDraftItem={saveDraftItem}
                listingOptions={listingOptions}
                selectedListing={selectedListing}
                selectListing={selectListing}
                fetchingShippingRates={fetchingShippingRates}
                shippingRates={shippingRates}
                selectedShippingRate={selectedShippingRate}
                selectShippingRate={selectShippingRate}
                link={link}
                setLink={setLink}
                details={details}
                setDetails={setDetails}
                price={price}
                setPrice={setPrice}
                quantity={quantity}
                setQuantity={setQuantity}
              />
            </div>
          </div>
        </div>
        <div className="col-md-4 ml-auto">
          <div className="row">
            <div className="col-md-12">
              {!gettingOrder &&
                <React.Fragment>
                  <div className="row">
                    <div className="col-md-6">
                      <h2 className="mb-3">Draft Order</h2>

                    </div>
                    <div className="col-md-6 text-right">
                      <h2>#{orderDetails[0].id}</h2>
                    </div>
                  </div>
                  <CustomerInfo order={orderDetails[0]} />
                </React.Fragment>
              }
            </div>
          </div>
          <div className="row mt-3">
            <div className="col-md-12">
              {!fetchingOrderItems && orderItems &&
                <DraftItems draftItems={orderItems} />
              }
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const data = document.getElementById('draft-order-details').getAttribute('data-order-id');
  ReactDOM.render(<DraftOrderDetails orderId={data} />, document.getElementById('draft-order-details'));
});
