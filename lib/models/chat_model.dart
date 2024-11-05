class ChatModel {
  late String name;
  late String icon;
  late bool isGroup;
  late String time;
  late String about;
  late String currentMessage;
  ChatModel({
    required this.name, 
    required this.icon, 
    required this.isGroup, 
    required this.time, 
    required this.about,
    required this.currentMessage
  });
}
