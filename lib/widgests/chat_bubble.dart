import 'package:chat/models/message_model.dart';
import 'package:flutter/cupertino.dart';

import '../constans/colors.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({super.key, required this.message});
Message message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          message.message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
    );
  }
}
