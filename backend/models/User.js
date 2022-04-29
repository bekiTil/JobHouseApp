var mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
    min: 5,
    max: 20,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    min: 5,
    max: 35,
  },
  password: {
    type: String,
    required: true,
    min: 4,
    max: 1028,
  },
  name: {
    type: String,
    required: true,
    max: 50,
  },
  role: {
    type: String,
    required: true,
    default: "employee",
  },
  properties: Object,
});

module.exports = mongoose.model("User", userSchema);
