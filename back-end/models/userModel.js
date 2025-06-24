const mongoose = require("mongoose");

const userSchema = mongoose.Schema(
  {

    username:{
      type: String,
      required: [true, "Please add the user email address"],
    },
    email: {
      type: String,
      required: [true, "Please add the user email address"],
      // min:10,
      // validate :{
      //   validator : v => v/2 == 0,
      //   message : props => '${props.value } is not a valide email '
      // }
    },
    verified:{
      type: Boolean,
      default:false,
    },
    
    
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("User", userSchema);