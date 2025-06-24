const mongoose = require("mongoose");

const userOtpVerificationSchema = mongoose.Schema(
  {
    userId: {
      type: String,
      required: [true, "Please add the user userId address"]
    },
    otp: {
      type: String,
      required: [true, "Please add the user otp ss"],
    },
    createdAt :Date,
    expiresAt :Date,
    
  },
  {
    timestamps: false,
  }
);

module.exports = mongoose.model("UserOTP", userOtpVerificationSchema);