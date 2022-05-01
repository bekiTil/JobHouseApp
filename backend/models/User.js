var mongoose = require("mongoose");
const Joi = require("@hapi/joi");

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

const signupSchema = Joi.object({
  username: Joi.string().min(5).max(20).required(),
  email: Joi.string().email().min(5).max(35).required(),
  password: Joi.string().min(4).max(1028).required(),
  name: Joi.string().max(50).required(),
  role: Joi.string().required(),
});

const loginShema = Joi.object({
  username: Joi.string().min(5).max(20).required(),
  password: Joi.string().min(4).max(1028).required(),
});


module.exports = {
  User : mongoose.model("User", userSchema),
  signupValidation: (data) => signupSchema.validate(data),
  loginValidation : (data) => loginShema.validate(data)
}


