/**
 * Middleware to parse images
 */

const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "images/");
  },
  filename: (req, file, cb) => {
    cb(null, new Date().toISOString() + "-" + file.originalname);
  },
});

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 50,
  },
  fileFilter: (req, file, cb) => {
    cb(null, ["image/png", "image/jpeg", "image/jpg"].includes(file.mimetype));
  },
});

module.exports = upload;
