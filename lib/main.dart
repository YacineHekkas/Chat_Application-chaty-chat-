import 'package:flutter/material.dart';
import 'package:whatsapp_clone/view/Screens/LoginScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          fontFamily: "OpenSans",
          primaryColor: const Color(0xFF008069),
          indicatorColor: const Color(0xff007e69),
          scaffoldBackgroundColor:const Color(0xFFfefffe) ,
        useMaterial3: true,
      ),
      home: LoginScreen() , //Homescreen(chatmodels: Data.chatmodels, sourchat: Data.chatmodels[1],),
    );
  }
}

