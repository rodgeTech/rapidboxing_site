import React from "react";
import ReactDOM from "react-dom";
import { toast } from "react-toastify";

import axios from "../utils/axios";
import Form from "./contact/Form";

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

const Contact = () => {
  const submit = (values, setSubmitting, resetForm) => {
    setSubmitting(true);

    axios
      .post("contacts", values)
      .then((res) => {
        notify("Your message has been sent");
        setSubmitting(false);
        resetForm();
      })
      .catch(({ response }) => {
        warn("Make sure all fields are filled in");

        setSubmitting(false);
      });
  };
  return (
    <div className="container my-5">
      <div className="row">
        <div className="col-md-6 pr-sm-5 pb-5 pb-sm-0">
          <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d862.4800110741112!2d-89.07421387079968!3d17.156305599263597!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMTfCsDA5JzIyLjciTiA4OcKwMDQnMjUuMiJX!5e1!3m2!1sen!2sbz!4v1589325867792!5m2!1sen!2sbz"
            frameborder="0"
            style={{ border: 0, width: "100%", height: "400px" }}
            allowfullscreen=""
            aria-hidden="false"
            tabindex="0"
          ></iframe>
        </div>
        <div className="col-md-6 ml-auto">
          <h3 className="mb-4 title-light">Send us your message</h3>
          <Form submitMessage={submit} />
        </div>
      </div>
    </div>
  );
};

ReactDOM.render(<Contact />, document.getElementById("contact"));
