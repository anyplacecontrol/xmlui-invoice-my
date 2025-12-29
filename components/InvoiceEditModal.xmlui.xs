var invoice=invoicesState.value.invoiceToEdit

function handleEditInvoiceFormSubmit(toSave) {
  Actions.callApi({
    method: 'put',
    url: '/api/invoices/' + invoice.invoice_number,
    body: toSave,
    completedNotificationMessage: 'Invoice saved',
    errorNotificationMessage: 'Error saving invoice ',
  });
}
