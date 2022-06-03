const mongoose = require("mongoose");
const Joi = require("@hapi/joi");

const bookmarkSchema = mongoose.Schema({
  user_id: {
    type: mongoose.ObjectId,
    required: true,
  },
  post_id: {
    type: mongoose.ObjectId,
    required: true,
  },
  post: {
    type: Object

  },
  memo: {
    type: String,
    min: 5,
    max: 200,
    required: false,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const schema = Joi.object({
  user_id: Joi.string().hex().length(24).required(),
  post_id: Joi.string().hex().length(24).required(),
  memo: Joi.string().min(5).max(200),
  createdAt: Joi.string(),
});

module.exports = {
  bookmarkValidation: (data) => schema.validate(data),
  Bookmark: mongoose.model("Bookmark", bookmarkSchema),
};
