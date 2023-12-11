
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';

import '../Pages/ChatPage.dart';

class Homescreen extends StatefulWidget {
  Homescreen( {super.key, required this.chatmodels, required this.sourchat}) ;
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
            "WhatsApp",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.camera_alt_outlined,color: Colors.white,), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search, color: Colors.white,), onPressed: () {}),
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          unselectedLabelColor: Colors.white60,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.groups),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Placeholder(),
          // CameraPage(),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourchat: widget.sourchat,
          ),
          Placeholder(),
          Placeholder(),

        ],
      ),
    );
  }
}