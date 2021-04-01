import React, { useReducer, useEffect } from "react";
import ReactDOM from "react-dom";
import normalize from "json-api-normalizer";
import build from "redux-object";

import { useModal } from "../hooks/useModal";
import axios from "../utils/axios";

import Form from "./calculator/Form";
import Calculated from "./modals/Calculated";

const initialState = {
  selectRates: [],
  rates: [],
  selectedRate: {},
  gettingRates: true,
  calculating: false,
  calculatedValues: {},
};

const reducer = (state, action) => {
  switch (action.type) {
    case "GET_RATES_SUCCESS": {
      const { selectRates, rates } = action;
      return {
        ...state,
        selectRates,
        rates,
        gettingRates: false,
      };
    }
    case "GET_RATES_FAILURE": {
      return {
        ...state,
        gettingRates: false,
      };
    }
    case "CALCULATE_SUCCESS": {
      const { calculatedValues } = action;
      return {
        ...state,
        calculatedValues,
        calculating: false,
      };
    }
    case "SELECT_RATE": {
      const { id } = action;
      return {
        ...state,
        selectedRate: state.rates.find((r) => r.id === id),
      };
    }
    default:
      return state;
  }
};

const Calculator = () => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const { show, RenderModal } = useModal();

  useEffect(() => {
    axios
      .get(`settings/weight_shipping_rates`)
      .then(({ data }) => {
        const ratesData = normalize(data, {
          endpoint: "/weight_shipping_rates",
        });
        const weightRates = build(ratesData, "weightShippingRate", null);
        console.log(weightRates);
        const selectRates = weightRates.map((rate) => ({
          value: rate.id,
          label: `${rate.name} (${rate.minOrderWeight} lb - ${rate.maxOrderWeight} lb)`,
        }));

        dispatch({
          type: "GET_RATES_SUCCESS",
          selectRates,
          rates: weightRates,
        });
      })
      .catch(() => {
        dispatch({ type: "GET_RATES_FAILURE" });
      });
  }, []);

  const calculate = (values, setSubmitting, setFieldError) => {
    setSubmitting(true);

    const params = {
      quantity: values.quantity,
      price: values.price,
      shipping_rate_id: values.shippingRate.value,
      extra_pounds: values.extraPounds,
      local_pickup: values.localPickup,
    };
    axios
      .get("calculator", {
        params: {
          ...params,
        },
      })
      .then(({ data }) => {
        console.log(data);
        dispatch({ type: "CALCULATE_SUCCESS", calculatedValues: data });
        setSubmitting(false);
        show();
      })
      .catch(() => {
        setSubmitting(false);
      });
  };

  const selectRate = (id) => {
    console.log(id);
    dispatch({ type: "SELECT_RATE", id });
  };

  const { gettingRates, selectRates, calculatedValues, selectedRate } = state;

  return (
    <div className="container my-5">
      <div className="row">
        <div className="col-md-6 mx-auto">
          <div className="custom-card rounded p-3">
            <div className="title title-md">Estimation Calculator</div>
            <p className="text-muted mb-5">
              Use our estimation calculator to give yourself an idea how much
              your order might total to.
            </p>
            <Form
              onSelectRate={selectRate}
              calculate={calculate}
              fetchingRates={gettingRates}
              shippingRates={selectRates}
            />
            <RenderModal contentStyles={{ width: "700px" }}>
              <Calculated
                calculatedValues={calculatedValues}
                selectedRate={selectedRate}
              />
            </RenderModal>
          </div>
        </div>
      </div>
    </div>
  );
};

ReactDOM.render(<Calculator />, document.getElementById("calculator"));
