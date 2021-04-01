import React, { useEffect, useReducer } from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";
import { toast } from "react-toastify";

import axios from "../utils/axios";
import Loader from "../common/Loader";
import Details from "./orderDetails/Details";
import OrderItems from "./orderDetails/OrderItems";
import Deposits from "./orderDetails/Deposits";
import Customer from "./orderDetails/Customer";
import Balance from "./orderDetails/Balance";
import OrderStatus from "./orderDetails/OrderStatus";

import Invoice from "./modals/Invoice";
import OrderItemDetails from "./modals/OrderItemDetails";
import EditOrderItem from "./modals/EditOrderItem";
import RecordDeposit from "./modals/RecordDeposit";

import { useModal } from "../hooks/useModal";

const initialState = {
  order: {},
  orderItems: [],
  invoice: {},
  deposits: [],
  users: [],
  loading: true,
  statusEnum: "",
  status: "",
  weightShippingRates: [],
  selectedShippingRates: [],
  orderItem: {},
  total: 0.0,
  balance: 0.0,
  hasInvoice: false,
};

toast.configure({
  autoClose: 3000,
  draggable: false,
});

const notify = (message) =>
  toast.success(message, {
    position: toast.POSITION.TOP_RIGHT,
  });

const warn = (message) =>
  toast.warn(message, {
    position: toast.POSITION.TOP_RIGHT,
  });

const reducer = (state, action) => {
  switch (action.type) {
    case "GET_ORDER_SUCCESS": {
      const {
        order,
        orderItems,
        invoice,
        deposits,
        users,
        selectedShippingRates,
        weightShippingRates,
        total,
        balance,
        hasInvoice,
      } = action;
      return {
        ...state,
        order,
        orderItems,
        invoice,
        deposits,
        users,
        statusEnum: order.attributes.status_enum,
        status: order.attributes.status,
        loading: false,
        selectedShippingRates,
        weightShippingRates,
        total,
        balance,
        hasInvoice,
      };
    }
    case "CREATE_INVOICE_SUCCESS":
      const { invoice } = action;
      return {
        ...state,
        invoice,
        hasInvoice: true,
      };
    case "GET_ORDER_FAILURE":
      return { ...state, loading: false };
    case "SELECT_ORDER_ITEM":
      return {
        ...state,
        orderItem: action.orderItem,
      };
    default:
      return state;
  }
};

const OrderDetails = ({ orderId }) => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const {
    show: showInvoiceModal,
    RenderModal: RenderInvoiceModal,
  } = useModal();

  const {
    show: showItemDetailsModal,
    RenderModal: RenderItemDetailsModal,
  } = useModal();

  const {
    show: showEditItemModal,
    RenderModal: RenderEditItemModal,
  } = useModal();

  const {
    show: showRecordDepositModal,
    RenderModal: RenderRecordDepositModal,
  } = useModal();

  useEffect(() => {
    axios
      .get(`orders/${orderId}`)
      .then((res) => {
        const order = res.data.data;
        const orderItems = res.data.included.filter(
          (value) => value.type === "order_item"
        );
        const deposits = res.data.included.filter(
          (value) => value.type === "deposit"
        );
        const users = res.data.included.filter(
          (value) => value.type === "user"
        );
        const invoice = res.data.included.find((obj) => {
          return obj.type === "invoice";
        });
        const selectedShippingRates = res.data.included.filter(
          (value) => value.type === "shipping_rate"
        );
        const weightShippingRates = res.data.meta.weight_shipping_rates.data;
        const priceShippingRates = res.data.meta.price_shipping_rates.data;
        const total = res.data.meta.total;
        const balance = res.data.meta.balance;

        dispatch({
          type: "GET_ORDER_SUCCESS",
          order,
          orderItems,
          deposits,
          invoice,
          users,
          weightShippingRates,
          priceShippingRates,
          selectedShippingRates,
          total,
          balance,
          hasInvoice: !!order.attributes.invoice_emailed_at,
        });
      })
      .catch(() => {
        dispatch("GET_ORDER_FAILURE");
      });
  }, []);

  const createDeposit = (values, setSubmitting, setFieldError) => {
    const { amount } = values;
    axios
      .post("deposits", {
        order_id: orderId,
        amount,
      })
      .then((res) => {
        window.location.reload();
      })
      .catch(({ response }) => {
        setSubmitting(false);
        setFieldError("amount", response.data.errors[0]);
      });
  };

  const deleteDeposit = (id) => {
    axios
      .delete(`deposits/${id}`)
      .then((res) => {
        window.location.reload();
      })
      .catch(({ response }) => {
        warn("Failed to delete deposit");
      });
  };

  const updateStatus = (status) => {
    axios
      .put(`orders/${orderId}/status_update`, {
        status: status,
      })
      .then((res) => {
        window.location.reload();
      })
      .catch(({ response }) => {
        warn("Failed to update order status");
      });
  };

  const archiveOrder = () => {
    axios
      .patch(`orders/${orderId}/archive`)
      .then((res) => {
        window.location.href = `/admin/orders/archives/${orderId}`;
      })
      .catch(({ response }) => {
        warn("Failed to archive order");
      });
  };

  const updateOrderItem = (values, setSubmitting) => {
    setSubmitting(true);

    const { price, shippingRate, quantity, extraPounds, localPickup } = values;

    axios
      .put(`order_items/${orderItem.id}`, {
        price,
        shipping_rate_id: shippingRate,
        quantity,
        extra_pounds: extraPounds,
        local_pickup: localPickup,
      })
      .then(window.location.reload())
      .catch(({ response }) => {
        setSubmitting(false);

        warn("Failed to update order item");
      });
  };

  const createInvoice = () => {
    const { order } = state;
    axios
      .post(`/orders/${state.order.id}/email_invoice`, {
        order_id: order.id,
      })
      .then((res) => {
        const invoice = res.data.data;
        dispatch({
          type: "CREATE_INVOICE_SUCCESS",
          invoice,
        });
        window.location.reload();
      })
      .catch(({ response }) => {
        setSubmitting(false);
        notify("Failed to create invoice");
      });
  };

  const selectOrderItem = (orderItem, callback) => {
    dispatch({ type: "SELECT_ORDER_ITEM", orderItem });
    callback();
  };

  if (state.loading) return <Loader styles={{ marginTop: "10px" }} />;

  const {
    order,
    invoice,
    orderItems,
    deposits,
    users,
    status,
    statusEnum,
    selectedShippingRates,
    weightShippingRates,
    orderItem,
    total,
    balance,
    hasInvoice,
  } = state;

  return (
    <div className="row">
      <div className="col-md-12">
        <OrderStatus
          status={status}
          currentStatusEnum={statusEnum}
          statusesEnum={order.attributes.statuses_enum}
          statuses={order.attributes.statuses}
        />
      </div>
      <div className="col-md-12">
        <div className="row">
          <div className="col-md-9">
            <Details
              order={order}
              hasInvoice={hasInvoice}
              updateStatus={updateStatus}
              statusEnum={statusEnum}
              status={status}
              createInvoice={createInvoice}
              archiveOrder={archiveOrder}
              invoice={invoice}
              showInvoiceModal={showInvoiceModal}
            />
            <OrderItems
              orderItems={orderItems}
              selectedShippingRates={selectedShippingRates}
              toggleModal={(orderItem) =>
                selectOrderItem(orderItem, showEditItemModal)
              }
              toggleItemDetailsModal={(orderItem) =>
                selectOrderItem(orderItem, showItemDetailsModal)
              }
              hasInvoice={hasInvoice}
            />
          </div>
          <div className="col-md-3">
            <div className="row">
              <div className="col-md-12">
                <Balance balance={balance} total={total} />
              </div>
            </div>
            <div className="row mt-4">
              <div className="col-md-12">
                <Customer order={order} />
              </div>
            </div>
            <div className="row mt-4 mb-5">
              <div className="col-md-12">
                <Deposits
                  deposits={deposits}
                  users={users}
                  toggleModal={showRecordDepositModal}
                  hasInvoice={hasInvoice}
                  deleteDeposit={deleteDeposit}
                  archive={order.attributes.archive}
                />
              </div>
            </div>
          </div>
          <RenderEditItemModal
            title="Edit Order Item"
            contentStyles={{ width: "500px" }}
          >
            <EditOrderItem
              updateItem={updateOrderItem}
              orderItem={orderItem}
              weightShippingRates={weightShippingRates}
            />
          </RenderEditItemModal>
          <RenderItemDetailsModal>
            <OrderItemDetails orderItem={orderItem} />
          </RenderItemDetailsModal>
          <RenderInvoiceModal>
            <Invoice pdfUrl={`/admin/orders/${order.id}/invoice.pdf`} />
          </RenderInvoiceModal>
          <RenderRecordDepositModal
            title="Record Payment Deposit"
            contentStyles={{ width: "500px" }}
          >
            <RecordDeposit createDeposit={createDeposit} />
          </RenderRecordDepositModal>
        </div>
      </div>
    </div>
  );
};

OrderDetails.propTypes = {
  orderId: PropTypes.string.isRequired,
};

document.addEventListener("DOMContentLoaded", () => {
  const data = document
    .getElementById("order-details")
    .getAttribute("data-order-id");
  ReactDOM.render(
    <OrderDetails orderId={data} />,
    document.getElementById("order-details")
  );
});
