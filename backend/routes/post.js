/**
 * TODO: 1: add token authorization
 * TODO: 2: add poster_id to each post from token
 */

const router = require("express").Router();
const { Post, postValidation } = require("../models/Post");
const upload = require("../middleware/image");

/**
 *
 * Handles creation and update of a post. If postId === null: it
 * creates the post else it updates a post with id === postId
 *
 * @param {*} req
 * @param {*} res
 * @param {*} postId
 */
async function postHandler(req, res, postId) {
  const { error } = postValidation(req.body);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  let post;
  ({ description, category, number, poster_id } = req.body);

  if (postId) {
    try {
      post = await Post.findOne({ _id: req.params.postId });
    } catch (error) {
      return res.status(401).send("Post doesn't exist!");
    }
  } else {
    post = new Post({poster_id: 1});
  }

  post.description = description;
  post.category = category;
  post.number = number;

  if (req.file) {
    post.image = req.file.path;
  }

  res.send(await post.save());
}

router.post("", upload.single("postImage"), async (req, res) => {
  await postHandler(req, res, null);
});

router.get("/:postId", async (req, res) => {
  try {
    const post = await Post.findOne({ _id: req.params.postId });
    if (post) return res.send(post);
  } catch (error) {
    return res.status(400).send("Post doesn't exist!");
  }
});

router.get("user/:username", (req, res) => {
  res.send("fetched from username");

  // TODO: fetch all the posts
});

router.get("/delete/:postId", async (req, res) => {
  try {
    res.send(await Post.deleteOne({ _id: req.params.postId }));
  } catch (error) {
    res.status(401).send("Something went wrong!");
  }
});

router.post("/edit/:postId", upload.single("postImage"), async (req, res) => {
  await postHandler(req, res, req.params.postId);
});

module.exports = router;
