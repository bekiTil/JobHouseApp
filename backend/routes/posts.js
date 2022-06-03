const router = require("express").Router();
const { User } = require("../models/User");
const { Post, postValidation } = require("../models/Post");

const upload = require("../middleware/image");
const authorize = require("../middleware/authorize");
const Role = require("../models/Role");

router.post(
  "",
  authorize(Role.Company),
  upload.single("image"),
  async (req, res) => {
    req.body.poster_id = req.auth._id;

    const { error } = postValidation(req.body);

    if (error) {
      return res.status(400).send(error.details[0].message);
    }

    ({ poster_id, description, category, number } = req.body);

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

// Get all posts
router.get("/", async (req, res) => {
  Post.find()
    .then((posts) => res.send(posts))
    .catch((error) => {
      console.log(error)
      return res.status(400).send("An Error occured")});
});

// Get post information by its post id
router.get("/:id", async (req, res) => {
  try {
    const post = await Post.findOne({ _id: req.params.id });
    if (post) return res.send(post);
  } catch (error) {
    return res.status(400).send("Post doesn't exist!");
  }
});

// Get all posts from a given user
router.get("/user/:id", async (req, res) => {
  const user = await User.findOne({ id: req.params.id });
  
  if (!user) {
    return req.status(401).send("User doesn't exist!");
  }
  const response = await Post.find({ poster_id: req.params.id });
  console.log(req.params.id)
  res.send(response);
});

// Delete a post by its id
router.delete("/:id", authorize(Role.Company), async (req, res) => {
  console.log(req.params.id);
  
  let post;
  try {
    post = await Post.findOne({ _id: req.params.id });

    if (req.auth._id != post.poster_id) {
      throw Error("Not the owner");
    }
    res.status(204).send(await post.delete());
  } catch (error) {
    res.status(401).send("Post is not found!");
  }
});

// Edit post
router.put(
  "/:id",
  authorize(Role.Company),
  upload.single("image"),
  async (req, res) => {
    try {
      ({ description, category, number } = req.body);

      const post = await Post.findOne({ _id: req.params.id });

      if (post.poster_id != req.auth._id) {
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
