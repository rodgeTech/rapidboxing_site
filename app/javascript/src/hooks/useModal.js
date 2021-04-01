import React, { useState } from "react";

import Modal from "../common/Modal";

export const useModal = () => {
  const [isVisible, setIsVisible] = useState(false);

  const show = () => setIsVisible(true);
  const hide = () => setIsVisible(false);

  const RenderModal = ({ title, contentStyles, children }) => (
    <React.Fragment>
      {isVisible && (
        <Modal
          title={title}
          closeModal={hide}
          isOpen={isVisible}
          contentStyles={contentStyles}
        >
          {children}
        </Modal>
      )}
    </React.Fragment>
  );

  return {
    show,
    hide,
    RenderModal,
  };
};
