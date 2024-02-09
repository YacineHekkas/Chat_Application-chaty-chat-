
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/view/Screens/HomeScreen.dart';

class TmpLoginScreen extends StatefulWidget {
  const TmpLoginScreen({super.key});

  @override
  State<TmpLoginScreen> createState() => _TmpLoginScreenState();
}

class _TmpLoginScreenState extends State<TmpLoginScreen> {
  @override
  late ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),

    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),

    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),

    // ChatModel(
    //   name: "NodeJs Group",
    //   isGroup: true,
    //   currentMessage: "New NodejS Post",
    //   time: "2:00",
    //   icon: "group.svg",
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
            onTap: () {
              sourceChat = chatmodels.removeAt(index);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => Homescreen(
                        chatmodels: chatmodels,
                        sourchat: sourceChat,
                      )));
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 23,
                child: Icon(
                   Icons.person,
                  size: 26,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF25D366),
              ),
              title: Text(
                chatmodels[index].name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          )),
    );
  }
}
