const express = require('express');
const axios = require('axios');
const app = express();
 
app.get('/', (req, res) => {
  res
    .status(200)
    .send('Hello, world!')
    .end();
});
 
// Start the server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
  console.log('Press Ctrl+C to quit.');
});

axios
  .get('https://db.ygorganization.com/data/card/10001')
  .then(res => {
    console.log(`statusCode: ${res.status}`);
    console.log(res["data"]["cardData"]["en"]);
  })
  .catch(error => {
    console.error(error);
  });