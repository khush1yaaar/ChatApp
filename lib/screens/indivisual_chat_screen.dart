import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/screens/camera/camera_screen.dart';
import 'package:chatapp/widgets/own_message_card.dart';
import 'package:chatapp/widgets/reply_message_card.dart';
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
    socket.onConnect((data) => print("connected!!!"));
    socket.emit("signin", widget.sourcechat.id);
    print("${socket.connected} connected");
  }

  void sendMessage(String message, int sourceId, int targetId) {
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
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
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                    OwnMessageCard(),
                    ReplyMessageCard(),
                  ],
                ), // Placeholder for chat messages
              ),
              _buildMessageInput(),
              if (_showEmojiPicker) _buildEmojiPicker(),
            ],
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
                        sendMessage(_controller.text, widget.sourcechat.id,
                            widget.chatmodel.id);
                      }
                      _controller.clear();
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
