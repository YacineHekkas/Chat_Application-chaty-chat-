const { addMessage, getAllMessage, talkedList } = require("../controllers/messageController");


const router = require("express").Router();

router.post("/addmsg/", addMessage);
router.post("/getmsg/", getAllMessage);
router.post("/talkedList/", talkedList);



module.exports = router;