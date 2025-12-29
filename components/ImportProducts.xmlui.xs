var parsedCsv = null;
var selectedItems = [];
var processedCount = 0;
var isImporting = false;

function isDuplicate(name) {
  // function to check for duplicates
  return existingProducts.value.some((p) => p.name === name);
}

function importSelected() {
  processedCount = 0;
  isImporting = true;
  importQueue.enqueueItems(selectedItems);
}

function handleImportProduct(processing) {
  // Update progress
  processing.reportProgress(processedCount + 1);
  // Make API call to upload objects (delay happens server-side)
  const result = Actions.callApi({
    url: "/api/products",
    method: "POST",
    body: processing.item,
  });
  delay(1000);
  processedCount++;
  return result;
}

function handleImportComplete() {
  isImporting = false;
  importProductsTable.clearSelection();
}
