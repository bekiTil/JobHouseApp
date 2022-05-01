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

const fileFilter = (req, file, cb) => {
  cb(null, ["image/png", "imaeg/jpeg", "image/jpg"].includes(file.mimetype));
};

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 50,
  },
  fileFilter: fileFilter,
});

/**
 *
 * @param {*} fieldName
 * @returns Multer object that can parse an image sent with field name <fieldName>
 */
module.exports = upload;
