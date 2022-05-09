const router = require("express").Router();
const User = require("../models/User");
const { Post, postValidation } = require("../models/Post");

const verifyToken = require("../middleware/verifyToken");
const isCompany = require("../middleware/isCompany");
const upload = require("../middleware/image");

router.post(
  "",
  verifyToken,
  isCompany,
  upload.single("image"),
  async (req, res) => {
    req.body.poster_id = req.user._id;

    const { error } = postValidation(req.body);

    if (error) {
      return res.status(400).send(error.details[0].message);
    }

    ({ poster_id, description, category, number, poster_id } = req.body);

    const post = new Post({
      poster_id: poster_id,
      description: description,
      category: category,
      number: number,
    });

    if (req.file) {
      post.image = req.file.path;
    }

    res.send(await post.save());
  }
);
router.get("/:id", async (req, res) => {
  try {
    const post = await Post.findOne({ _id: req.params.id });
    if (post) return res.send(post);
  } catch (error) {
    return res.status(400).send("Post doesn't exist!");
  }
});

router.get("/user/:username", async (req, res) => {
  const user = await User.findOne({ username: req.params.username });

  if (!user) {
    return req.status(401).send("User doesn't exist!");
  }

  res.send(await Post.find({ poster_id: user._id }));
});

router.get("/delete/:id", verifyToken, isCompany, async (req, res) => {
  let post;
  try {
    post = await Post.findOne({ _id: req.params.id });

    if (req.user._id != post.poster_id) {
      throw Error("Not the owner");
    }

    res.send(await post.delete());
  } catch (error) {
    res.status(401).send("Post is not found!");
  }
});

router.post(
  "/edit/:id",
  verifyToken,
  isCompany,
  upload.single("image"),
  async (req, res) => {
    try {
      ({ description, category, number } = req.body);

      const post = await Post.findOne({ _id: req.params.id });

      if (post.poster_id != req.user._id) {
        throw Error("Not the owner!");
      }

      post.description = description;
      post.category = category;
      post.number = number;

      if (req.file) {
        post.image = req.file.path;
      }

      res.send(await post.save());
    } catch (error) {
      res.status(401).send("Post doesn't exist!");
    }
  }
);

module.exports = router;