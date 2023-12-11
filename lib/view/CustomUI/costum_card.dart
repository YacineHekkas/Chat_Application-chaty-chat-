
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/view/Screens/DiscussionScreen.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.sourchat, required this.chatModel} );
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => DiscussionScreen(
                  chatModel: chatModel,
                  sourchat: sourchat,
                )
            )
        );
      },
      child: Column(
        children: [

           Padding(
            padding: EdgeInsets.only(top: 8,bottom: 0),
            child:ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.blueGrey,
                child: Container(
                  // chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                  color: Colors.blue,
                  height: 36,
                  width: 36,
                ),
              ),
              title: Text(
                chatModel.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: [
                  const Icon(Icons.done_all),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    chatModel.currentMessage,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              trailing: Text( "${chatModel.time} pm"),
            ),

          ),
        ],
      ),
    );
  }
}