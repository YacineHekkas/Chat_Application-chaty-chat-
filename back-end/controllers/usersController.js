const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const User = require("../models/userModel");
const UserOTP = require("../models/userOtpVerificationModel");
const nodemailer = require("nodemailer");
const bcrypt = require('bcryptjs');

//@desc login user
//@route POST /api/user/login
//@access public

const searchUser = asyncHandler(async (req, res) => {
  
  const query = req.body.query;
  if ( !query ) {
    res.status(400);
    throw new Error("All fields are mandatory!");
  }
  const users = await User.find({

    $or: [
      { username: { $regex: `^${query}`, $options: 'i' } },
      { email: { $regex: `^${query}`, $options: 'i' } },
      
    ]
    

  });
  const filteredUsers = users.filter(user => user.verified) .map(
    user => ({ _id: user._id, username: user.username })
    ); 
  res.status(200).json({
    data:{users:filteredUsers}
  })

  
})

const loginUser = asyncHandler(async (req, res) => {
  const { email,username } = req.body;
  if ( !email ) {
    res.status(400);
    throw new Error("All fields are mandatory!");
  }
  const user = await User.findOne({ email });
  console.log("GG");
  if (user) 
    {
      // const accessToken = jwt.sign(
      //   {
      //     user: {
      //       // username: user.username,
      //       email: user.email,
      //       id: user.id,
      //     },
      //   },
      //   process.env.ACCESS_TOKEN_SECERT,
      //   { expiresIn: "15m" }
      // );
      console.log("GG2");
       verificationMail(user.email,user);
       console.log("GG3");
      res.status(200).json({
        message:`Verification email has been sent to ${email} check your mail`,
        data:{
          _id: user.id,
          email: user.email,
          
        }
          
        });
        console.log("GGwe");
    }
  else{
    console.log("creating new user ");
    const user = await User.create({
      username,
      email,
    });
    console.log(`User created ${user}`);
    if (user) {
      
      verificationMail(user.email,user);
      
      res.status(200).json({
        message:`Verification email has been sent to ${email} check your mail`,
        data:{
          _id: user.id,
         email: user.email
        }
        
         });
    } else {
      res.status(400);
      throw new Error("User data is not valid");
    }
      res.json({ message: "Register the user" });
    }
});



const currentUser = asyncHandler( async (req, res) => {
  res.json(req.user)
});
//@desc Login user
//@route POST /api/user/verifingOTP
//@access public
const verifingOTP = asyncHandler(async (req, res) => {
  const{userId,otp} = req.body;
  if(!userId || !otp){
    res.status(400);
    throw new Error("All fields are mandatory!");
  }else{
    const userfound = await UserOTP.find({userId});
    if(userfound.length <= 0 ){
      res.status(404);
      throw new Error("User doesn't exist");
    }else{

      const {expiresAt} = userfound[userfound.length-1].expiresAt;
      if(expiresAt <= Date.now){
        await UserOTP.deleteMany({ userId: userId });
        throw new Error("Code expired. request again.")

      }else{
        
        const validOtp =  bcrypt.compareSync(otp,userfound[userfound.length-1].otp)
      
        if(validOtp){
          
          await User.updateOne( {_id : userId},{verified : true});
         
          const result = await UserOTP.deleteMany({ userId: userId });
          console.log(result);
          res.status(200).json({
            message:"user is verified"
          })
        }else{
             res.status(400);
              throw new Error("not valide code");
        }
      }

      }
  }
  
});


const verificationMail = asyncHandler(
  async(email,user,res)=>{
    const OTP= `${Math.floor(1000+Math.random()*9000)}`;
    const transporter = nodemailer.createTransport({
      service : "Gmail",
      auth:{
        user :'yacinehekkas7@gmail.com',
        pass : 'xysd pluq tfxp hajz'

      }
    });
    const mailOptions = ({
      from: process.env.UserEmail,
      to: email,
      subject: "ACCOUNT VERIFICATION",
      text: "Welcom",
      html: `<div>
            <h1> HERE IS YOUR VERIFICATION CODE : ${OTP} </h1>
         </div>`
    });
    
    const hashedOTP =  bcrypt.hashSync(OTP);
    
    const userId = user.id;
    const newOTPVerification = await  UserOTP.create({
       userId,
       otp:hashedOTP,
       createdAt:Date.now(),
       expiresAt:Date.now()+3600000
      
    });
  
    await newOTPVerification.save();
    transporter.sendMail(mailOptions)
    
  }
) 


module.exports = {loginUser,currentUser,verifingOTP,searchUser}