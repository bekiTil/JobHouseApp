const router = require("express").Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const User = require("../models/User");

const signupValidation = require("./validation/signupValidation");
const loginValidation = require("./validation/loginValidation");

router.post("/signup", async (req, res) => {
  const { error } = signupValidation(req.body);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  ({ username, email, password, name, role } = req.body);

  const emailExist = await User.findOne({ email: email });
  const usernameExist = await User.findOne({ username: username });

  if (emailExist) {
    return res.status(400).send("Email already exists!");
  } else if (usernameExist) {
    return res.status(400).send("Username already exists!");
  }

  // Hash the password
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(password, salt);
  const user = new User({
    username: username,
    email: email,
    password: hashedPassword,
    name: name,
    role: role,
  });

  try {
    res.send(await user.save());
  } catch (err) {
    res.status(400).send("Something went wrong!");
  }
});

router.post("/login", async (req, res) => {
  const { error } = loginValidation(req.body);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  ({ username, password } = req.body);

  const user = await User.findOne({ username: username });

  if (!user) {
    return res.status(400).send("Username doesn't match!");
  }

  const validPass = await bcrypt.compare(password, user.password); // boolean

  if (!validPass) {
    return res.status(400).send("Password is incorrect!");
  }

  // Create a token
  const token = jwt.sign(
    { _id: user._id, role: user.role },
    process.env.TOKEN_SECRET
  );

  return res.header("token", token).json({
    token: token,
  });
});

module.exports = router;
