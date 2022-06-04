const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const cors = require("cors");

dotenv.config();

// Connect to db
mongoose
  .connect(process.env["DATABASE"])
  .then(() => console.log("connected to mongo db..."))
  .catch((err) => console.log("Cannot connect to mongodb...", err));

// Import Routes
const users = require("./routes/users");
const auth = require("./routes/auth");
const postRoute = require("./routes/posts");
const bookmarkRoute = require("./routes/bookmark");

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Route Middleware
app.use("/images", express.static("images"));
app.use("/api/posts", postRoute);
app.use("/api/bookmarks", bookmarkRoute);
app.use("/api/users", users);
app.use("/login", auth);
app.listen(3000, () => console.log("Server started listening!!"));
