const express = require("express");
const http = require("http");
const bodyParser = require("body-parser");
const path = require('path'); 

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(express.static(__dirname + "/public"));

app.get("/status", (req, res) => {
	res.send("The server is running properly.");
});

app.get("/", (req, res) => {
	res.sendFile(path.dirname(__dirname)+'/public/views/index.html');
}); 

module.exports = app;
