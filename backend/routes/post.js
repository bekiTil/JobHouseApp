const router = require("express").Router();

const verifyToken = require("./validation/verifyToken");

router.post("", verifyToken, (req, res) => {
  res.send("posted successfully!");
});

module.exports = router;
