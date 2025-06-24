const router = require("express").Router();

// const validateToken = require("../middleware/validateTokenHandler");
const {  loginUser, currentUser,verifingOTP,searchUser } = require("../controllers/usersController");



// router.post("/register", registerUser);

router.post("/login", loginUser);
router.post("/verifingOTP", verifingOTP);
router.get("/searchUser", searchUser);

// router.get("/current",validateToken, currentUser);

module.exports = router;