
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
            padding: const EdgeInsets.only(top: 8,bottom: 0),
            child:ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blueGrey,

                  //TODO add photo from the backend
                  // chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                  backgroundImage: NetworkImage("https://media.istockphoto.com/id/455257149/photo/black-and-white-portrait-of-a-man.jpg?s=2048x2048&w=is&k=20&c=8qYBNWhLPNcNC66rwaFha1at1bDSmqTT_6gWlZxuX6k="),

              ),
              title: Text(
                chatModel.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: [

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