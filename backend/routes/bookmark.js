const router = require("express").Router();

const User = require("../models/User");
const { Post } = require("../models/Post");
const { Bookmark, bookmarkValidation } = require("../models/Bookmark");

const authorize = require("../middleware/authorize");
const Role = require("../models/Role");

// Create bookmark
router.post("", authorize(Role.Employee), async (req, res) => {
 
  
  req.body.user_id = req.auth._id;
  

  const { error } = bookmarkValidation(req.body);
  console.log("hi")
  if (error) {
    console.log(error)
    return res.status(400).send(error.details[0].message);
  }

  ({ user_id, post_id, memo } = req.body);
  console.log("hi")
  
  try {
    const post = await Post.findOne({ _id: post_id });
    console.log(post)
   
    if (!post) {
      throw Error("Post doesn't exist!");
    }
    const bookmark = new Bookmark({
      user_id: user_id,
      post_id: post_id,
      post: post,
      
    });
    console.log(post)
    if (memo) {
      bookmark.memo = memo;
    }
    console.log(bookmark);
    res.send(await bookmark.save());
  } catch (error) {
    return res.status(401).send(error);
  }

 
});

// Get all the saved bookmarks of the user who made this get request
router.get("", authorize(Role.Employee), async (req, res) => {
  return res.send(
    await Bookmark.find({ user_id: req.auth._id }).sort({
      createdAt: -1,
    })
  );
});

// Edit memo of a bookmark
router.put("/:id", authorize(Role.Employee), async (req, res) => {
  try {
    ({ memo } = req.body);

    const bookmark = await Bookmark.findOne({ _id: req.params.id });

    if (bookmark.user_id != req.auth._id) {
      throw Error("Not the owner!");
    }

    bookmark.memo = memo;

    res.send(await bookmark.save());
  } catch (error) {
    res.status(401).send("Bookmark doesn't exist!");
  }
});

// Deletes a bookmark
router.delete("/:id", authorize(Role.Employee), async (req, res) => {
  try {
    const bookmark = await Bookmark.findOne({ _id: req.params.id });

    if (req.auth._id != bookmark.user_id) {
      throw Error("Not the owner");
    }

    res.send(await bookmark.delete());
  } catch (error) {
    res.status(401).send("Bookmark is not found!");
  }
});

module.exports = router;
