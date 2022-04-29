const Joi = require("@hapi/joi");

const schema = Joi.object({
  username: Joi.string().min(5).max(20).required(),
  password: Joi.string().min(4).max(1028).required(),
});

module.exports = (data) => schema.validate(data);
