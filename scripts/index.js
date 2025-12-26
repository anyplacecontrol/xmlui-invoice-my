window.config = {};
fetch("config.json")
  .then((r) => (r.ok ? r.json() : {}))
  .then((c) => Object.assign(window.config, c));

window.parseCsv = function (file, setter) {
  // Read and parse CSV file, call setter with array of objects
  const reader = new FileReader();
  reader.onload = function(e) {
    const csvText = e.target.result;
    const result = Papa.parse(csvText, {
      header: true,
      skipEmptyLines: true,
      dynamicTyping: true
    });
    setter(result.data.map((item, idx) => ({ ...item, id: idx })));
  };
  reader.onerror = function(e) {
    console.error('parseCsv: Error reading CSV file:', e);
    setter([]);
  };
  reader.readAsText(file);
};
