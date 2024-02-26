import 'package:chat/constans/colors.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/widgests/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgests/another_chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTyping = false;
  TextEditingController messageController = TextEditingController();
  String? message;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final ScrollController _controller = ScrollController();

  // This function scrolls the ListView to the end with animation
  void _scrollToBottom() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: messages.orderBy('createdAt', descending: true).get(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapShot.data!.docs.length; i++) {
            messageList.add(
              Message.fromJson(
                snapShot.data!.docs[i],
              ),
            );
          }
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: kBackgroundColor,
                title: const Text(
                  'Chat',
                ),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.video_call)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert)),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].email == widget.email
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: AnotherChatBubble(
                                    message: messageList[index],
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: ChatBubble(
                                    message: messageList[index],
                                  ),
                                );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: kActiveColor,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  isTyping = false;
                                });
                              } else {
                                setState(() {
                                  isTyping = true;
                                });
                              }
                              message = value;
                            },
                            controller: messageController,
                            decoration: InputDecoration(
                              fillColor: kBackgroundColor,
                              hintText: 'Message',
                              prefixIcon:
                                  const Icon(Icons.emoji_emotions_outlined),
                              suffixIcon: const Icon(Icons.camera_alt),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kActiveColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (isTyping) {
                                setState(() {
                                  messages.add({
                                    'message': message,
                                    'createdAt': DateTime.now(),
                                    'email': widget.email,
                                  });
                                  messageController.clear();
                                  _scrollToBottom();
                                  isTyping = false;
                                });
                              } else {
                                _scrollToBottom();
                              }
                            },
                            icon: isTyping
                                ? const Icon(
                                    Icons.send_rounded,
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 70.0,
                                      ),
                                    ],
                                  )
                                : const Icon(
                                    Icons.mic,
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 70.0,
                                      ),
                                    ],
                                  ),
                            iconSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: true,
              child: Container(
                color: Colors.black,
              ),
            ),
          );
        }
      },
    );
  }
}
