const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");

dotenv.config();

// Connect to db
mongoose.connect(process.env['DATABASE'])
.then(()=>console.log("connected to mongo db..."))
.catch((err)=>console.log("Cannot connect to mongodb...", err)); 

// Import Routes
const users = require('./routes/users')
const auth = require('./routes/auth')
const postRoute = require("./routes/post");

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Route Middleware
app.use("/api/users", users);
app.use('/login', auth)
app.use("/images", express.static("images"));
app.use("/api/posts", postRoute);

app.listen(3000, () => console.log("Server started listening!!"));
