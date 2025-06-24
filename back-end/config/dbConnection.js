const mongoose = require('mongoose') ;

const connectDB = async ()=>{
    try {
        const conncet = await mongoose.connect(process.env.CONNECTION_STRING);
        console.log(
            "data BaseConnected",
            conncet.connection.host,
            conncet.connection.name
        )
    } catch (error) { 
        console.log(error);
        process.exit(1)
    }
}

module.exports = connectDB;