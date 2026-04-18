const express = require('express');
const app = express();
const PORT = process.env.PORT || 4000;

app.get('/', (req, res) => {
  res.send('<h1>Hello! Version 2 - Watchtower works! 🚀</h1>');
});

app.listen(PORT, () => console.log(`🚀 App is running on port ${PORT}`));