const express = require('express');
const app = express();

require('dotenv').config();
const connectDB = require("./config/dbConnection");
const errorHandler = require("./middleware/errorHandling");

const PORT = process.env.PORT || 3000;


const http = require('http').createServer(app);

connectDB();

app.use(express.json());

app.use("/api/users",require("./routes/authRoute"));
app.use("/api/message",require("./routes/messagesRoute"));

app.use(errorHandler);

const io = require('socket.io')(http)


http.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

// socket 

//global.onlineUsers =  new Map();

var clients = {}
 
io.on("connection",(socket)=>{

  console.log("Connected");
  console.log(socket.id, "has joind the party");

  socket.on("signin",(userId) => {
    clients[userId] = socket;
    console.log(clients)
  });
  socket.on("message",(mssg)=>{
    console.log(mssg);
    if(clients[mssg.targetId]){
      clients[mssg.targetId].emit("message",mssg)
    }
    
  })


    // global.chatSocket = socket;
    // socket.on("add-user",(userId)=>{
    //     onlineUsers.set(userId,socket.id);
    // });

    // socket.on("send-msg",(data)=>{
    //     const sendUserSocket = onlineUsers.get(data.to);
    //     if(sendUserSocket) {
    //         socket.to(sendUserSocket).emit("msg-recieved",data.message);
    //     }
    // });
}
);