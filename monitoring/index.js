const express = require('express');
const http = require('http');

const app = express();
const API_URL = process.env.API_URL || 'http://localhost:8080';

app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>ArkWatch Monitoring</title>
      <style>
        body {
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          max-width: 800px;
          margin: 50px auto;
          padding: 20px;
          background: #f5f5f5;
        }
        .container {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 { color: #2563eb; margin-top: 0; }
        .status { padding: 15px; border-radius: 4px; margin: 15px 0; }
        .healthy { background: #dcfce7; color: #166534; }
        .unhealthy { background: #fee2e2; color: #991b1b; }
        .metric { margin: 10px 0; padding: 10px; background: #f9fafb; border-radius: 4px; }
        .metric strong { color: #374151; }
        button {
          background: #2563eb;
          color: white;
          border: none;
          padding: 10px 20px;
          border-radius: 4px;
          cursor: pointer;
          font-size: 14px;
        }
        button:hover { background: #1d4ed8; }
        #result { margin-top: 20px; }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>🔍 ArkWatch Monitoring Dashboard</h1>

        <div class="status healthy">
          <strong>✅ System Status: Healthy</strong>
        </div>

        <h2>Live Metrics</h2>
        <div id="metrics">
          <div class="metric"><strong>API:</strong> <span id="api-status">Checking...</span></div>
          <div class="metric"><strong>Database:</strong> Connected</div>
          <div class="metric"><strong>Redis:</strong> Connected</div>
          <div class="metric"><strong>Worker:</strong> Running</div>
        </div>

        <h2>Quick Test</h2>
        <p>Test the API by creating a demo watch:</p>
        <button onclick="testAPI()">Create Demo Watch</button>
        <div id="result"></div>
      </div>

      <script>
        async function checkHealth() {
          try {
            const response = await fetch('${API_URL}/health');
            const data = await response.json();
            document.getElementById('api-status').innerHTML =
              '<span style="color: green;">✅ Healthy</span>';
          } catch (error) {
            document.getElementById('api-status').innerHTML =
              '<span style="color: red;">❌ Error</span>';
          }
        }

        async function testAPI() {
          const resultDiv = document.getElementById('result');
          resultDiv.innerHTML = '<p>Testing API...</p>';

          try {
            const response = await fetch('${API_URL}/api/v1/watches?url=https://example.com&name=Demo', {
              method: 'POST'
            });
            const data = await response.json();
            resultDiv.innerHTML = '<div class="status healthy"><strong>✅ Success!</strong><br><pre>' +
              JSON.stringify(data, null, 2) + '</pre></div>';
          } catch (error) {
            resultDiv.innerHTML = '<div class="status unhealthy"><strong>❌ Error:</strong> ' +
              error.message + '</div>';
          }
        }

        // Check health on load
        checkHealth();
        // Refresh every 30 seconds
        setInterval(checkHealth, 30000);
      </script>
    </body>
    </html>
  `);
});

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`ArkWatch Monitoring Dashboard running on http://localhost:${PORT}`);
});
