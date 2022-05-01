const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const user = req.user;

  if (user.role !== "company") {
    return res
      .status(401)
      .send("Service Denied! Posting is not allowed for employees!");
  }

  next();
};
