const router = require("express").Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const authorize =require("../middleware/authorize");
const Role =require("../models/Role");
const {User, signupValidation, loginValidation} = require("../models/User");


//signup route 
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


//sample authorization which u must be admin to access the route 
// and it works
router.get("/users",authorize(Role.Admin),(req,res)=>
  User.find({})
  .then(users=>res.send(users)).
  catch(err=>res.status(400).
  send("Something went wrong!"))
)


//login route 
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
    
    { username: user.username, role: user.role },
    process.env.TOKEN_SECRET
  );

  return res.header("token", token).json({
    token: token,
  });
});

module.exports = router;
