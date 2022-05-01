const express = require("express")
const mongoose = require("mongoose");
const {User, validate} = require("../models/User")
const _ = require('lodash');
const bcrypt = require("bcrypt");
const authorize = require('../middleware/authorize')
const Role = require('../models/Role')
const verifyToken = require("../middleware/verifyToken")

const router = express.Router();

router.get("/",authorize(Role.Admin),(req,res)=>
  User.find({})
  .then(users=>res.send(users)).
  catch(err=>res.status(400).
  send("Something went wrong!"))
)

router.get("/:id", async (req, res) => {
    const user = await User.findById(req.params.id);
    if (!user) return res.status(404).send("A user with the given Id was not found");
    res.send(user);
});

router.post("/", async(req, res) => {
    
    const{ error } = validate(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    ({ username, email, password, fullNname, role } = req.body);

    const emailExist = await User.findOne({ email: email });
    const usernameExist = await User.findOne({ username: username });

    if (emailExist) {
        return res.status(400).send("Email already exists!");
    } else if (usernameExist) {
        return res.status(400).send("Username already exists!");
    }

    let user = User(_.pick(req.body, ['username','fullName', 'email', 'password', 'profile', 'role']));
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password, salt);
    await user.save();
    
    const token = user.generateAuthToken();
    try {
        res.header('x-auth-token', token).send(_.pick(user, ['_id','name', 'email']));
      } catch (err) {
        res.status(400).send("Something went wrong!");
      }
});

router.put("/:id", verifyToken, async(req, res) => {
    
  const{ error } = validate(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  ({ username, email, password, fullNname, role } = req.body);

  let user = await User.findOne({ _id: req.params.id });

  user.username = req.body.username
  user.email = req.body.email
  user.fullName = req.body.fullName
  user.role = req.body.role
  user.profile = req.body.profile

  await user.save();
  
  try {
      res.send(_.pick(user, ['_id','name', 'email']));
    } catch (err) {
      res.status(400).send("Something went wrong!");
    }
});


module.exports = router;
