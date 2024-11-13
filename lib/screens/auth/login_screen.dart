import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/widgets/contact_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel(
      name: "Alice Johnson",
      icon: "person_icon1.png",
      isGroup: false,
      time: "10:30 AM",
      about: "Excited about life!",
      currentMessage: "Hey! Are we meeting later?",
      id: 1,
    ),
    ChatModel(
      name: "Bob Smith",
      icon: "person_icon2.png",
      isGroup: false,
      time: "9:45 AM",
      about: "Coding my way through",
      currentMessage: "I finished the code, check it out!",
      id: 2,
    ),
    ChatModel(
      name: "Emily Clark",
      icon: "person_icon3.png",
      isGroup: false,
      time: "8:15 PM",
      about: "Coffee enthusiast ☕",
      currentMessage: "See you at the café!",
      id: 4,
    ),
    ChatModel(
      name: "Mia Wong",
      icon: "person_icon4.png",
      isGroup: false,
      time: "6:05 AM",
      about: "Travel lover 🌍",
      currentMessage: "Sent you the itinerary!",
      id: 6,
    ),
    ChatModel(
      name: "Jake Paul",
      icon: "person_icon5.png",
      isGroup: false,
      time: "11:20 AM",
      about: "Foodie 🍕",
      currentMessage: "Let's grab lunch!",
      id: 8,
    ),
    ChatModel(
      name: "Sarah Lee",
      icon: "person_icon6.png",
      isGroup: false,
      time: "Yesterday",
      about: "Nature photographer 📷",
      currentMessage: "Check out my latest photos!",
      id: 9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => chats[index].isGroup
              ? Container()
              : InkWell(
                  onTap: () {
                    sourceChat = chats.removeAt(index);
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => HomeScreen(chats))
                    );
                  },
                  child:
                      ContactCard(name: chats[index].name, avatar: "", status: "")),
        ),
      ),
    );
  }
}
