// import 'package:camera/camera.dart';
// import 'package:chatapp/CustomUI/CameraUI.dart';


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Models/chat_model.dart';
import 'package:whatsapp_clone/Models/message_model.dart';
import 'package:whatsapp_clone/view/CustomUI/own_messag_card.dart';
import 'package:whatsapp_clone/view/CustomUI/replay_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiscussionScreen extends StatefulWidget {
  DiscussionScreen({ super.key, required this.chatModel, required this.sourchat}) ;
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  _DiscussionScreen createState() => _DiscussionScreen();
}

class _DiscussionScreen extends State<DiscussionScreen> {
  bool show = false;
  late IO.Socket socket;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    getAllmessage(widget.sourchat.id, widget.chatModel.id);
    connect();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
     socket = IO.io("http://localhost:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    print("--->${socket.connected}");
    socket.emit("signin", widget.sourchat.id);
    socket.onConnect((data) {
      print("--> Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);

        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut
        );
      });
    });
    print(socket.connected);
  }

  Future<void> sendMessage(String message, int sourceId, int targetId) async {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});


    try {
      Dio dio = Dio();

      String apiUrl = "http://localhost:5000/api/message/addmsg";

      Map<String, dynamic> data = {
        'from': "$sourceId" ,
        'to':"$targetId",
        'message':message
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
        // Successful response, handle accordingly
        print("Response data: ${response.data}");
      } else {
        // Handle error response
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      // Handle Dio errors
      print("Dio error: $error");
    }
  }



  Future<void> getAllmessage( int sourceId, int targetId ) async {
    print("i'm trynig to get the messages ");
    try {
      print('1');
      Dio dio = Dio();

      String apiUrl = "http://localhost:5000/api/message/getmsg";
      print('1');
      Map<String, dynamic> data = {
        'from': "$sourceId" ,
        'to':"$targetId",
      };

      Response response = await dio.post(
        apiUrl,
        data: jsonEncode(data),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print("2");
      if (response.statusCode == 200) {
        print("Response data: ${response.data[1]}");
        for (  int i = 0 ; i<  response.data.length ; i++ ){
          String typeMssg =  response.data[i]['fromSelf'] ? "source":"destination";
          setMessage( typeMssg , response.data[i]['message']);
        }

      } else {
        // Handle error response
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      // Handle Dio errors
      print("Dio error: $error");
    }

  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
       children: [
      //   Image.asset(
      //     "assets/whatsapp_Back.png",
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //     fit: BoxFit.cover,
      //   ),
        Scaffold(

          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: PreferredSize (
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              centerTitle: true,

              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:
                    Icon(
                      Icons.arrow_back_rounded,
                      color: Theme.of(context).indicatorColor,
                      size: 26,
                    ),


                ),
              title: Stack(
                children: [

                  Row(
                    children: [
                      CircleAvatar (
                        radius: 20,
                        backgroundColor: Colors.blueGrey,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        widget.chatModel.name,
                        style: const TextStyle(

                          fontSize: 18.5,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    right: 0,
                      left: 20,
                      child:  ExpandableMenu(
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
                          width: 40.0,
                          height: 40.0,
                          items: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                            ),

                          ],
                        ),

                  ),


                ],
              ),
              actions: [

              ],
            ),
          ),
          body: Container(



            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  color:Colors.white, //Theme.of(context).scaffoldBackgroundColor,
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Message",
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          show
                                              ? Icons.keyboard
                                              : Icons.emoji_emotions_outlined,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          if (!show) {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                          }
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.attach_file,color: Colors.grey,),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.camera_alt,color: Colors.grey,),
                                            onPressed: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (builder) =>
                                              //             CameraApp()));
                                            },
                                          ),

                                        ],
                                      ),
                                      contentPadding: const EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 2,
                                  left: 2,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                            const Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            _controller.text,
                                            widget.sourchat.id,
                                            widget.chatModel.id);
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          !show ? Container() : Container()//: emojiSelect(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
               semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }



  // Widget emojiSelect() {
  //   return EmojiPicker(
  //       rows: 4,
  //       columns: 7,
  //       onEmojiSelected: (emoji, category) {
  //         print(emoji);
  //         setState(() {
  //           _controller.text = _controller.text + emoji.emoji;
  //         });
  //       });
  // }
}