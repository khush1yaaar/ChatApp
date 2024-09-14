import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/widgets/chat_card.dart';
import 'package:flutter/material.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Khushi (me)",
        icon: "person.svg",
        isGroup: false,
        time: "4:00",
        currentMessage: "Hi, keep going...",
    ),
    ChatModel(
        name: "College group",
        icon: ".svg",
        isGroup: true,
        time: "4:00",
        currentMessage: "Hi, keep going...",
    ),
    ChatModel(
        name: "Khushi (me)",
        icon: "person.svg",
        isGroup: false,
        time: "4:00",
        currentMessage: "Hi, keep going...",
    ),
    ChatModel(
        name: "Khushi (me)",
        icon: "person.svg",
        isGroup: false,
        time: "4:00",
        currentMessage: "Hi, keep going...",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => 
        ChatCard(
          chat: chats[index],
        ),
      ),
    );
  }
}
