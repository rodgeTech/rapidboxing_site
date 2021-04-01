import React, { useState } from "react";
import { Document, Page, pdfjs } from "react-pdf";
import { SizeMe } from "react-sizeme";

import Loader from "../../common/Loader";

pdfjs.GlobalWorkerOptions.workerSrc = `//cdnjs.cloudflare.com/ajax/libs/pdf.js/${pdfjs.version}/pdf.worker.js`;

const Invoice = ({ pdfUrl }) => {
  const [numPages, setNumPages] = useState(null);
  const [pageNumber, setPageNumber] = useState(1);

  const onDocumentLoadSuccess = ({ numPages }) => {
    setNumPages(numPages);
  };

  const loader = () => (
    <Loader styles={{ marginTop: "10px", marginBottom: "30px" }} />
  );

  return (
    <React.Fragment>
      <SizeMe
        monitorHeight
        refreshRate={128}
        refreshMode={"debounce"}
        render={({ size }) => (
          <div>
            <Document
              file={pdfUrl}
              onLoadSuccess={onDocumentLoadSuccess}
              loading={loader}
            >
              <p className="text-center font-size-xs">
                <a href={pdfUrl} target="_blank" className="link text-muted">
                  <i class="fas fa-save mr-1"></i> Download
                </a>
              </p>
              <Page pageNumber={pageNumber} width={size.width} />
            </Document>
          </div>
        )}
      />
    </React.Fragment>
  );
};

export default Invoice;
