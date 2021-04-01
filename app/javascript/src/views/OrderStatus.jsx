import React, { useReducer, useEffect } from "react";
import ReactDOM from "react-dom";
import axios from "../utils/axios";
import StatusTimeline from "./orderStatus/StatusTimeline";

const initialState = {
  order: {},
  gettingOrder: true,
  failed: false,
};

const reducer = (state, action) => {
  switch (action.type) {
    case "GET_ORDER": {
      return {
        ...state,
        gettingOrder: true,
        failed: false,
      };
    }
    case "GET_ORDER_SUCCESS": {
      const { order } = action;
      return {
        ...state,
        order,
        gettingOrder: false,
      };
    }
    case "GET_ORDER_FAILURE":
      return { ...state, failed: true, gettingOrder: false };
    default:
      return state;
  }
};

const OrderStatus = ({ trackingNumber }) => {
  const [state, dispatch] = useReducer(reducer, initialState);

  useEffect(() => {
    if (!trackingNumber) {
      window.location.href = "/track_order";
      return;
    }
    axios
      .get(`track_order/${trackingNumber}`)
      .then((res) => {
        const order = res.data.data;
        dispatch({ type: "GET_ORDER_SUCCESS", order });
      })
      .catch(() => {
        dispatch({ type: "GET_ORDER_FAILURE" });
      });
  }, []);

  if (state.gettingOrder) return null;

  const { order, failed } = state;

  return (
    <div className="container">
      {failed ? (
        <div className="text-center">
          <h3>Something went wrong....</h3>
          <p>
            Ensure the tracking number you entered is correct and{" "}
            <a href="/track_order" className="link text-secondary">
              try again
            </a>
          </p>
        </div>
      ) : (
        <React.Fragment>
          <div className="row">
            <div className="col-md-6">
              <p className="m-0">Placed on {order.attributes.created_at}</p>
            </div>
            <div className="col-md-6 text-sm-right">
              <p className="m-0">Tracking Number: {trackingNumber}</p>
            </div>
          </div>
          <div>
            <StatusTimeline
              statuses={order.attributes.statuses}
              statusesEnum={order.attributes.statuses_enum}
              currentStatusEnum={order.attributes.status_enum}
              trackingNumber={order.attributes.tracking_number}
              trackOrder={() => dispatch({ type: "TOGGLE_TRACK_ORDER" })}
            />
          </div>
        </React.Fragment>
      )}
    </div>
  );
};

document.addEventListener("DOMContentLoaded", () => {
  const data = document
    .getElementById("order-status")
    .getAttribute("data-tracking-number");
  ReactDOM.render(
    <OrderStatus trackingNumber={data} />,
    document.getElementById("order-status")
  );
});
