
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/view/CustomUI/costum_card.dart';

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
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            slivers:  [
              SliverAppBar(
                expandedHeight: 120.0,
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                pinned: true,
                title: const Text(
                  "Chaty Chat",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.person_2_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      // TODO: Add action for the person icon
                    },
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 26),
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90.0),
                        topRight: Radius.circular(90.0),
                      ),
                    ),
                    child: TabBar(
                      controller: _controller,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Theme.of(context).indicatorColor,
                      indicatorColor: Theme.of(context).indicatorColor,
                      tabs: [
                        Tab(
                          text: "CHATS",
                        ),
                        Tab(
                          text: "CALLS",
                        ),
                      ],
                    ),
                  ),
                ),
              ),

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
          Positioned(

            bottom: 20,
            right: 20,

            child: FloatingActionButton(
              backgroundColor: Theme.of(context).indicatorColor,
            onPressed: () {
              //TODO :: add search screen and methods for the backend
            },
            child: Icon(
                Icons.add,
              color: Colors.white,
            ),
          ),)
        ],
      )
    );

  }
}