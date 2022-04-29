const Joi = require("@hapi/joi");

const schema = Joi.object({
  username: Joi.string().min(5).max(20).required(),
  email: Joi.string().email().min(5).max(35).required(),
  password: Joi.string().min(4).max(1028).required(),
  name: Joi.string().max(50).required(),
  role: Joi.string().required(),
});

module.exports = (data) => schema.validate(data);
