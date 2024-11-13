class ChatModel {
  late String name;
  late String icon;
  late bool isGroup;
  late String time;
  late String about;
  late String currentMessage;
  late int id;
  ChatModel({
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.about,
    required this.currentMessage,
    required this.id
    });
}
