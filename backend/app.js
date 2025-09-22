const express = require('express');
const app = express();
app.use(express.json());

let products = [
  { id: 1, name: "Laptop", price: 50000 },
  { id: 2, name: "Mobile", price: 20000 }
];

app.get('/', (req, res) => res.send("Simple E-Com API Running"));
app.get('/products', (req, res) => res.json(products));

app.listen(3000, () => console.log("Server running on port 3000"));

