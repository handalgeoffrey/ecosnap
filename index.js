
const functions = require('@google-cloud/functions-framework');
const { WasteClassification } = require('./waste_classification'); // Assuming you have a similar model in Node.js

// Register an HTTP function
functions.http('classifyWaste', (req, res) => {
  // For this example, we'll return a mock response.
  // In a real application, you would process the image from the request
  // and use a machine learning model to classify it.

  // Set CORS headers to allow requests from any origin
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST');
  res.set('Access-Control-Allow-Headers', 'Content-Type');


  if (req.method === 'OPTIONS') {
    // Pre-flight request. Reply successfully:
    res.status(204).send('');
    return;
  }
  
  // Mock response that matches the Flutter app's expected structure
  const mockResponse = [
    {
      "label": "Plastic",
      "confidence": 0.92
    },
    {
      "label": "Paper",
      "confidence": 0.05
    },
    {
      "label": "Glass",
      "confidence": 0.03
    }
  ];

  res.status(200).json(mockResponse);
});
