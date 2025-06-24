const messageModel = require("../models/messageModel");
const User  = require("../models/userModel");


const addMessage = async (req, res, next) => {
    
    try {
        console.log("=--1-0");
        const {from,to,message} = req.body;
        if(!from || !to || !message){
            res.status(400);
            throw new Error("All fields are mandatory!");
        }
        console.log("=--1");
        const data = await messageModel.create({
            message:{
                text: message
            },
            users: [
                from,
                to
            ],
            sender:from,
        });
        

        console.log("=-->2");
        if(data) return res.status(200).json({
            msg: "Message added successfully!"
        });
        return res.status(500).json({ 
            msg: "Failed to add message to DB"
        });

    } catch (err) {
        next(err);
    }
};

const getAllMessage = async (req, res, next) => {
    try {
        console.log("=-->1");
        const {from,to} = req.body;
        if(!from || !to ){
            res.status(400);
            throw new Error("All fields are mandatory!");
        }
        console.log("=-->2");
        const messages = await messageModel.find({
            users:{
                $all: [from,to],
            },
        });//.sort({ updatedAt: 1 });
        console.log("=--->3");
        
        // console.log("=-->3",messages);
        const projectMessages = messages.map((msg)=>{
            return{
                fromSelf: msg.sender.toString() === from,
                message: msg.message.text,
            };
        });
        console.log("=-->4");
        console.log(projectMessages);
        res.status(200).json(projectMessages);
    } catch (error) {
        next(error);
    }
};

const talkedList = async(req, res, next) => {
    try{
    const {userId} = req.body;
        if(!userId ){
            res.status(400);
            throw new Error("All fields are mandatory!");
        }
    const messages = await messageModel.find({ 
        users:{
            $all:[userId]
        }
     },)
      console.log(messages);
      const otherUsers = [];

        messages.forEach(message => {
        if (message.users.includes(userId)) {
        const otherUser = message.users.find(user => user !== userId);
        otherUsers.push(otherUser);
        }
        });

        const usersWithUsernames = [];

        for (const id of otherUsers) {
          const username = await getUsernameById(id);
          if (username) {
            usersWithUsernames.push({ id, username });
          }
        }

        console.log(usersWithUsernames);
        res.status(200).json(otherUsers);
    } catch (error) {
        next(error);
    }


}


async function getUsernameById(userId) {
    try {
      // Recherche de l'utilisateur par son ID
      const user = await User.findById(userId);
      return user ? user.username : null; // Retourne le nom d'utilisateur si trouvé, sinon null
    } catch (error) {
      console.error('Erreur lors de la recherche du nom d\'utilisateur :', error);
      throw error; // Vous pouvez gérer l'erreur en conséquence dans votre application
    }
  }

module.exports = {addMessage , getAllMessage,talkedList}