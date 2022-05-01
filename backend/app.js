const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");

dotenv.config();

// Connect to db
mongoose.connect(process.env.DB, () => console.log("Connected to db!"));

// Import Routes
const authRoute = require("./routes/auth");
const postRoute = require("./routes/post");

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Route Middleware
app.use("", authRoute);
app.use("/images", express.static("images"));
app.use("/post", postRoute);

app.listen(3000, () => console.log("Server started listening!!"));
