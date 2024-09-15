import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatBubble({Key? key, required this.text, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: isMe ? Colors.deepPurple[100] : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: isMe ? Colors.black : Colors.black87)),
    );
  }
}
