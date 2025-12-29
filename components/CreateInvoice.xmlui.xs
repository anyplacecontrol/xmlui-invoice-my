var newInvoice = {
  client: "",
  issueDate: window.getTodayDate(),
  dueDate: "",
  items: [],
  total: 0,
};

function recalculateTotal() {
  newInvoice.total = newInvoice.items.reduce((sum, item) => sum + item.amount, 0);
}

function handleAddItem() {
  newInvoice.items.push({ product: "", description: "", quantity: 1, price: 0, amount: 0 });
  recalculateTotal();
}

function updateItem(rowIndex, productName) {
  // Find the product by productName from products data source
  // "products" refers to the data source defined at the top of the component
  const product = products.value.find((p) => p.name === productName);
  if (product) {
    newInvoice.items[rowIndex] = {
      product: product.name,
      description: product.description,
      quantity: newInvoice.items[rowIndex].quantity,
      price: product.price,
      amount: product.price * newInvoice.items[rowIndex].quantity,
    };
    recalculateTotal();
  }
}

function handleDeleteItem(rowIndex) {
  newInvoice.items = newInvoice.items.filter((item, index) => index !== rowIndex);
  recalculateTotal();
}

function handleUpdateItemQuantity(rowIndex, quantity) {
  newInvoice.items[rowIndex].quantity = quantity;
  newInvoice.items[rowIndex].amount = newInvoice.items[rowIndex].price * quantity;
  recalculateTotal();
}

function handleSubmit(formData) {
  newInvoice = {
    items: JSON.stringify(newInvoice.items),
    client: formData.client,
    issueDate: formatDate(newInvoice.issueDate, "yyyy-MM-dd"),
    dueDate: formatDate(formData.dueDate, "yyyy-MM-dd"),
    total: newInvoice.total,
  };
  Actions.callApi({
    method: "POST",
    url: "/api/invoices",
    body: newInvoice,
    completedNotificationMessage: "Invoice created successfully!",
    errorNotificationMessage: "Error creating invoice ",
    onSuccess: "Actions.navigate('/invoices')",
  });
}

function handleWillSubmit() {
  if (!newInvoice.items.length > 0) {
    toast.error("At least one line item is required.");
    return false;
  }

  if (!newInvoice.items.every((item) => item.product && item.quantity > 0)) {
    toast.error("Please ensure all line items have a product selected and quantity greater than zero.");
    return false;
  }
  return true;
}
