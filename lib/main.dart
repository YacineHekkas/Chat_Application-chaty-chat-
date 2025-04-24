import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whatsapp_clone/Const/dummy_data.dart';
import 'package:whatsapp_clone/view/Screens/Auth/LoginScreen.dart';
import 'package:whatsapp_clone/view/Screens/HomeScreen.dart';
import 'package:whatsapp_clone/view/Screens/TmpLoginScreen.dart';

bool loggedIn= true;
void main() {
  //checkIfTheUserIsSigned();
  runApp(ProviderScope( child: const MyApp() ,));
}

Future<void> checkIfTheUserIsSigned() async {


  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  //await secureStorage.delete(key: 'userId');
  String?  authToken = await secureStorage.read(key: 'userId');
  loggedIn = (authToken != null);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          fontFamily: "OpenSans",
          primaryColor: const Color(0xFFc7417b),
          primaryColorLight: const Color(0xfffbe9ef),
          indicatorColor: const Color(0xff553772),
          dividerColor: const Color(0xfffff5f8),
          scaffoldBackgroundColor:const Color(0xFFfefffe) ,
        useMaterial3: true,
      ),
      home: loggedIn?LoginScreen():Homescreen(chatmodels: Data.chatmodels, sourchat: Data.chatmodels[1]) , //Homescreen(chatmodels: Data.chatmodels, sourchat: Data.chatmodels[1],),
    );
  }
}

