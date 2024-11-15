import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/screens/camera/camera_screen.dart';
import 'package:chatapp/widgets/chat_cards/own_message_card.dart';
import 'package:chatapp/widgets/chat_cards/reply_message_card.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: must_be_immutable
class IndivisualChatScreen extends StatefulWidget {
  ChatModel chatmodel;
  ChatModel sourcechat;
  IndivisualChatScreen(
      {super.key, required this.chatmodel, required this.sourcechat});

  @override
  // ignore: library_private_types_in_public_api
  _IndivisualChatScreenState createState() => _IndivisualChatScreenState();
}

class _IndivisualChatScreenState extends State<IndivisualChatScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _showEmojiPicker = false;
  final TextEditingController _controller = TextEditingController();
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [
    MessageModel(type: "R", message: "hello", time: "3:15")
  ];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void connect() {
    socket = IO.io("http://$ip_address:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      print("connected!!!");
      socket.on("message", (msg) {
        print(msg);
        setMessage("R", msg); // R - reviever
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Durations.short1, curve: Curves.easeOut);
      });
    });
    socket.emit("signin", widget.sourcechat.id);
    print("${socket.connected} connected");
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("S", message); // S - sender
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
  }

  void _toggleEmojiPicker() {
    if (_showEmojiPicker) {
      // Show keyboard and hide emoji picker
      setState(() {
        _showEmojiPicker = false;
      });
      _focusNode.requestFocus();
    } else {
      // Hide keyboard and show emoji picker
      setState(() {
        _showEmojiPicker = true;
      });
      _focusNode.unfocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide'); // Hide keyboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "lib/constants/images/blue_theme/chat_background.jpeg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blue.shade800,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.white), // Back arrow made white
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Row(
              children: [
                CircleAvatar(
                  child: Icon(
                      widget.chatmodel.isGroup ? Icons.group : Icons.person),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.chatmodel.name,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                    Text('last seen at ${widget.chatmodel.time}',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.video_call, color: Colors.white),
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.call, color: Colors.white),
                  onPressed: () {}),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == messages.length) {
                        return Container(
                          height: 60,
                        );
                      }
                      if (messages[index].type == 'R') {
                        return ReplyMessageCard(
                            msg: messages[index].message,
                            time: messages[index].time);
                      } else {
                        return OwnMessageCard(
                            msg: messages[index].message,
                            time: messages[index].time);
                      }
                    },
                  ), // Placeholder for chat messages
                ),
                _buildMessageInput(),
                if (_showEmojiPicker) _buildEmojiPicker(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions_outlined,
                            color: Colors.grey),
                        onPressed: _toggleEmojiPicker,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          focusNode: _focusNode,
                          onTap: () {
                            if (_showEmojiPicker) {
                              setState(() {
                                _showEmojiPicker =
                                    false; // Hide emoji picker when typing
                              });
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: InputBorder.none, // No border
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                sendButton = true;
                              });
                            } else {
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.attach_file, color: Colors.grey),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) => bottomSheet());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.grey),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CameraScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade800,
                child: IconButton(
                    onPressed: () {
                      if (sendButton) {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Durations.short1,
                            curve: Curves.easeOut);
                        sendMessage(_controller.text, widget.sourcechat.id,
                            widget.chatmodel.id);
                      }
                      _controller.clear();
                      setState(() {
                        sendButton = false;
                      });
                    },
                    icon: Icon(sendButton ? Icons.send : Icons.mic),
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 250, // Adjust the height according to your needs
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              iconCreation(Icons.insert_drive_file, Colors.indigo, "Document"),
              GestureDetector(
                  onTap: () {},
                  child: iconCreation(Icons.camera_alt, Colors.pink, "Camera")),
              iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              iconCreation(Icons.headset, Colors.orange, "Audio"),
              iconCreation(Icons.location_pin, Colors.green, "Location"),
              iconCreation(Icons.person, Colors.blue, "Contact"),
            ],
          ),
        ],
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {
        if (text == "Document") {
        } else if (text == "Camera") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CameraScreen()));
        } else if (text == "Gallery") {
        } else if (text == "Audio") {
        } else if (text == "Location") {
        } else if (text == "Contact") {}
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, size: 29, color: color),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          _controller.text = _controller.text +
              emoji.emoji; // Use emoji.emoji to get the actual emoji character
        });
      },
    );
  }
}
