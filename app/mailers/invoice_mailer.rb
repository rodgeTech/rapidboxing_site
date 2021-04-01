# frozen_string_literal: true

class InvoiceMailer < ApplicationMailer
  def new_invoice(invoice)
    @invoice = invoice
    @order = invoice.order

    attachments["invoice#{@invoice.public_uid}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string('application/_invoice.pdf.erb', layout: 'pdf.html')
    )
    mail(to: @order.email, subject: 'RapidBoxing order invoice')
  end
end
