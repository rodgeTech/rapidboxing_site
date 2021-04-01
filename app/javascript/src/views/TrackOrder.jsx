import React, { useReducer } from "react";
import ReactDOM from "react-dom";
import Form from "./trackOrder/Form";
import axios from "../utils/axios";
import Status from "./trackOrder/Status";

const initialState = {
  order: {},
  foundOrder: false,
};

const reducer = (state, action) => {
  switch (action.type) {
    case "GET_ORDER_SUCCESS": {
      const { order } = action;
      return {
        ...state,
        foundOrder: true,
        order,
      };
    }
    case "GET_ORDER_FAILURE":
      return { ...state, foundOrder: false };
    case "TOGGLE_TRACK_ORDER": {
      return {
        ...state,
        foundOrder: false,
        order: {},
      };
    }
    default:
      return state;
  }
};

const TrackOrder = () => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const trackOrder = (values, setSubmitting, setFieldError) => {
    const { trackingNumber } = values;
    axios
      .get(`track_order/${trackingNumber}`)
      .then((res) => {
        const order = res.data.data;
        window.location.href = `/order_status?tracking_number=${trackingNumber}`;
      })
      .catch(({ response }) => {
        setSubmitting(false);
        setFieldError("trackingNumber", response.data.error);
      });
  };

  const { order, foundOrder } = state;

  return (
    <div className="container my-5">
      <div className="row">
        <div className="col-md-6 mx-auto">
          {!foundOrder && (
            <div className="custom-card rounded p-3">
              <Form trackOrder={trackOrder} />
            </div>
          )}
          {foundOrder && (
            <Status
              statuses={order.attributes.statuses}
              statusesEnum={order.attributes.statuses_enum}
              currentStatusEnum={order.attributes.status_enum}
              trackingNumber={order.attributes.tracking_number}
              trackOrder={() => dispatch({ type: "TOGGLE_TRACK_ORDER" })}
            />
          )}
        </div>
      </div>
    </div>
  );
};

ReactDOM.render(<TrackOrder />, document.getElementById("track-order"));
