const mongoose = require("mongoose");
const Joi = require("@hapi/joi");

const postSchema = mongoose.Schema({
  poster_id: {
    type: mongoose.ObjectId,
    required: true,
  },
  posterName: {
    type: String,
  },
  description: {
    type: String,
    required: true,
    min: 5,
    max: 200,
  },
  category: {
    type: String,
    required: true,
  },
  number: {
    type: Number,
    required: true,
    min: 1,
  },
  createdAt: {
    type: Date,
    required: true,
    default: Date.now,
  },
  image: {
    type: String,
  },
});

const schema = Joi.object({
  poster_id: Joi.string().hex().length(24).required(),
  description: Joi.string().min(5).max(200).required(),
  category: Joi.string().required(),
  number: Joi.number().min(1).required(),
});

module.exports = {
  postValidation: (data) => schema.validate(data),
  Post: mongoose.model("Post", postSchema),
};
