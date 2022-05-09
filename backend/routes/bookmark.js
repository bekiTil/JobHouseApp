const router = require("express").Router();

const User = require("../models/User");
const { Post } = require("../models/Post");
const { Bookmark, bookmarkValidation } = require("../models/Bookmark");

const verifyToken = require("../middleware/verifyToken");
const isEmployee = require("../middleware/isEmployee");

/**
 * Create bookmark
 */
router.post("", verifyToken, isEmployee, async (req, res) => {
  req.body.user_id = req.user._id;

  const { error } = bookmarkValidation(req.body);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  ({ user_id, post_id, memo } = req.body);

  try {
    const post = await Post.findOne({ _id: post_id });

    if (!post) {
      throw Error("Post doesn't exist!");
    }
  } catch (error) {
    return res.status(401).send(error);
  }

  const bookmark = new Bookmark({
    user_id: user_id,
    post_id: post_id,
  });

  if (memo) {
    bookmark.memo = memo;
  }

  res.send(await bookmark.save());
});

/**
 * Get all the saved bookmarks of the user who made this get request
 */
router.get("", verifyToken, isEmployee, async (req, res) => {
  return res.send(
    await Bookmark.find({ user_id: req.user._id }).sort({
      createdAt: -1,
    })
  );
});

/**
 * Deletes a bookmark with _id = id
 */
router.get("/delete/:id", verifyToken, isEmployee, async (req, res) => {
  try {
    const bookmark = await Bookmark.findOne({ _id: req.params.id });

    if (req.user._id != bookmark.user_id) {
      throw Error("Not the owner");
    }

    res.send(await bookmark.delete());
  } catch (error) {
    res.status(401).send("Bookmark is not found!");
  }
});

module.exports = router;
