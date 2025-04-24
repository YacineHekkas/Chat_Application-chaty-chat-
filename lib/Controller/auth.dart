import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:dio/dio.dart';
import 'package:whatsapp_clone/Const/dummy_data.dart';
import 'package:whatsapp_clone/View/Screens/Auth/VerificationScreen.dart';
import 'package:whatsapp_clone/View/Screens/HomeScreen.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// PROVIDER REPOSITORY
class AuthRepository {


  // SIGN UP
  Future<String> login ({required String email, required String username }) async {
    try {
      Dio dio = Dio();

      String apiUrl = "http://localhost:5000/api/users/login";

      Map<String, dynamic> data = {
        'username':username,
        'email': email

      };

      Response response = await dio.post(
        apiUrl,
        data: jsonEncode(data),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Handle the response
      if (response.statusCode == 200) {


        print("Response data: ${response.data}");
        print("Response data: ${response.data["data"]["_id"]}");
        return response.data["data"]["_id"];
      } else {
        // Handle error response
        print("Error: ${response.statusCode}${response}");
        return "";
      }
    } catch (error) {
      return "";
      // Handle Dio errors
      print("Dio error: $error");
    }

  }
  Future<bool> otpVerifivation({required String otp,required String userID}) async {
    try {
      Dio dio = Dio();

      // Define the API endpoint
      String apiUrl = "http://localhost:5000/api/users/verifingOTP";

      // Prepare the request payload
      Map<String, dynamic> data = {
        'userId': userID,
        'otp':otp
      };



      // Send the POST request
      Response response = await dio.post(
        apiUrl,
        data: jsonEncode(data),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        print("Response data: ${response}");

        final FlutterSecureStorage secureStorage = FlutterSecureStorage();

        await secureStorage.write(key: 'UserId', value: userID);

        return true;

      } else {
        print("Error: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      print("Dio error: $error");
      return false;
    }
  }
  }


  final authNotifierProvider = StateNotifierProvider<AuthNotifier,bool>((ref) => AuthNotifier(ref.watch(authRepositoryProvider)));

class AuthNotifier extends StateNotifier < bool > {
  final AuthRepository _authRepository;
  AuthNotifier( this._authRepository) : super(false) ;
    login({required String email, required String username , required BuildContext context,})async{
      try{
        state = true;
        await _authRepository.login(email: email, username: username ).then((value) {
          print("__>$value");
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  VerificationScreen(userID: value) ));
        }
        );
        state = false;
      }catch(e){
        state = false;
      }


    }

   otpVerivication({required String otp,required String userID, required BuildContext context,})async{
    try{
      state = true;
      await _authRepository.otpVerifivation( otp: otp, userID: userID).then((value) {
        if(value){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homescreen(chatmodels: Data.chatmodels, sourchat:Data.chatmodels[0] )),
          );

        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: Text(' Wrong OTP code! try again'),
          ));
        }
      }

      );
      state = false;
    }catch(e){
      state = false;
    }


  }

}
