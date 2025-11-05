const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('🚀 Automated Node.js App deployed via Jenkins + Terraform + Docker!');
});

app.listen(port, () => {
  console.log(`App running at http://localhost:${port}`);
});
