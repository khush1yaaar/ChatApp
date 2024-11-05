import 'package:chatapp/models/chat_model.dart';

List<ChatModel> contacts = [
  ChatModel(
    name: "Alice Johnson",
    icon: "person_icon1.png",
    isGroup: false,
    time: "10:30 AM",
    about: "Excited about life!",
    currentMessage: "Hey! Are we meeting later?"
  ),
  ChatModel(
    name: "Bob Smith",
    icon: "person_icon2.png",
    isGroup: false,
    time: "9:45 AM",
    about: "Coding my way through",
    currentMessage: "I finished the code, check it out!"
  ),
  ChatModel(
    name: "Family Group",
    icon: "group_icon1.png",
    isGroup: true,
    time: "Yesterday",
    about: "Family comes first",
    currentMessage: "Dinner at 8?"
  ),
  ChatModel(
    name: "Emily Clark",
    icon: "person_icon3.png",
    isGroup: false,
    time: "8:15 PM",
    about: "Coffee enthusiast ☕",
    currentMessage: "See you at the café!"
  ),
  ChatModel(
    name: "Team Project",
    icon: "group_icon2.png",
    isGroup: true,
    time: "2:30 PM",
    about: "Team communication",
    currentMessage: "Let's discuss the deadline!"
  ),
  ChatModel(
    name: "Mia Wong",
    icon: "person_icon4.png",
    isGroup: false,
    time: "6:05 AM",
    about: "Travel lover 🌍",
    currentMessage: "Sent you the itinerary!"
  ),
  ChatModel(
    name: "Workout Buddies",
    icon: "group_icon3.png",
    isGroup: true,
    time: "5:45 PM",
    about: "Stay fit together",
    currentMessage: "Who's up for a run?"
  ),
  ChatModel(
    name: "Jake Paul",
    icon: "person_icon5.png",
    isGroup: false,
    time: "11:20 AM",
    about: "Foodie 🍕",
    currentMessage: "Let's grab lunch!"
  ),
  ChatModel(
    name: "Sarah Lee",
    icon: "person_icon6.png",
    isGroup: false,
    time: "Yesterday",
    about: "Nature photographer 📷",
    currentMessage: "Check out my latest photos!"
  ),
  ChatModel(
    name: "Book Club",
    icon: "group_icon4.png",
    isGroup: true,
    time: "3:10 PM",
    about: "Books & Discussions 📚",
    currentMessage: "Next meeting on Friday!"
  ),
];