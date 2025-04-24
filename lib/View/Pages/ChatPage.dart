
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Controller/chatController.dart';

import 'package:whatsapp_clone/Models/chat_model.dart';
import '../CustomUI/costum_card.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key, required this.chatmodels, required this.sourchat});
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  _ChatPageState createState() => _ChatPageState();

}



class _ChatPageState extends State<ChatPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).indicatorColor,
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body:CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return CustomCard(
                  chatModel: widget.chatmodels[index],
                  sourchat: widget.sourchat,
                );
              },
              childCount: widget.chatmodels.length,
            ),
          ),
        ],
      ),
    );
  }
}
