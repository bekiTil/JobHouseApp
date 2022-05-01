const Joi = require('joi');
const mongoose = require('mongoose');
const jwt = require('jsonwebtoken')

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
    fullName: {
      type: String,
      required: true,
      max: 50,
    },
    role: {
      type: String,
      required: true,
      default: "employee",
    },
    profile:{
      type: [Object]
    }
  });

userSchema.methods.generateAuthToken = function() {
    const token = jwt.sign({
      _id: this._id, 
      role:this.role
    }
    , process.env['JWT_PRIVATE_KEY']);
    return token
}

const User = mongoose.model('User', userSchema);

function validateUser(user){
  const companySchema = Joi.object({
      location: Joi.string().required(),
      bio: Joi.string()
    });

  const employeeSchema = Joi.object({
      fieldOfStudy: Joi.string().required(),
      educationLevel: Joi.string().required(),
      yearsOfExperience: Joi.number(),
      location: Joi.string().required(),
      bio: Joi.string()
    });

  const schema = Joi.object({
      username: Joi.string().min(3).max(255).required(),
      fullName: Joi.string().min(1).max(50).required(),
      email: Joi.string().min(10).max(255).required().email(),
      password: Joi.string().min(5).max(255).required(),
      role: Joi.string().min(4).max(20).required(),
      profile: Joi.alternatives()
                  .conditional('role', {
                  switch: [{
                      is: 'employee',
                      then:  Joi.array().items(employeeSchema),
                  }, {
                      is: 'company',
                      then: Joi.array().items(companySchema),
                  },
                  {
                      is: 'admin',
                      then:  Joi.array().items(employeeSchema),
                  }],
                  })
              })
  return schema.validate(user);
}

exports.User = User;
exports.validate = validateUser; 
