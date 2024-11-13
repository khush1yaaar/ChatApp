import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/screens/select_contact_screen.dart';
import 'package:chatapp/widgets/chat_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AllChatsScreen extends StatefulWidget {
  AllChatsScreen({super.key, required this.chatModels, required this.sourcechat});
  late List<ChatModel> chatModels;
  late ChatModel sourcechat;
  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 15),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelectContactScreen()));
          },
          child: const Icon(
            Icons.chat_bubble_outline_outlined,
            color: Color.fromARGB(255, 8, 100, 174),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (context, index) => ChatCard(
          chat: widget.chatModels[index],
          sourcechat: widget.sourcechat,
        ),
      ),
    );
  }
}
