import 'package:chatapp/models/chat_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IndivisualChatScreen extends StatefulWidget {
  ChatModel chatmodel;
  IndivisualChatScreen({super.key, required this.chatmodel});

  @override
  _IndivisualChatScreenState createState() => _IndivisualChatScreenState();
}

class _IndivisualChatScreenState extends State<IndivisualChatScreen> {
  // Focus node for detecting when the TextField is focused
  FocusNode _focusNode = FocusNode();
  // Variable to track if the keyboard is open
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    // Add listener to detect when the TextField is focused/unfocused
    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode
        .dispose(); // Dispose of the focus node when the widget is disposed
    super.dispose();
  }

  // The floating icon widget
  Widget _buildFloatingIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: Colors.black, size: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
      body: Stack(
        children: [
          // Background image layer (Fixed in place)
          Positioned.fill(
            child: Image.asset(
              'lib/const/images/chat_screen.png', // Path to your custom background image
              fit: BoxFit.cover,
            ),
          ),

          // Avatar and name on the top-left corner
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Icon(
                      widget.chatmodel.isGroup ? Icons.group : Icons.person),
                ),
                const SizedBox(width: 10), // Spacing between avatar and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatmodel.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'last seen at ${widget.chatmodel.time}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Floating call and video call icons (top-right corner)
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                _buildFloatingIcon(Icons.video_call),
                const SizedBox(width: 10),
                _buildFloatingIcon(Icons.call),
              ],
            ),
          ),

          // Enhanced Chat text field (bottom center with emoji, attachment, camera icons)
          Positioned(
            bottom: _isKeyboardVisible
                ? 300
                : 20, // Move up when keyboard is visible
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Remove focus from the TextField when the user taps outside
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Emoji icon
                    IconButton(
                      icon: Icon(Icons.emoji_emotions_outlined,
                          color: Colors.grey),
                      onPressed: () {
                        // Action for emoji picker (if needed)
                        _buildEmojiPicker();
                      },
                    ),
                    const SizedBox(width: 5),

                    // TextField for typing messages
                    Expanded(
                      child: TextField(
                        focusNode: _focusNode, // Attach the focus node
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Attachment icon
                    IconButton(
                      icon: Icon(Icons.attach_file, color: Colors.grey),
                      onPressed: () {
                        // Action for attachments
                      },
                    ),
                    const SizedBox(width: 5),

                    // Camera icon
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.grey),
                      onPressed: () {
                        // Action for camera
                      },
                    ),

                    // Microphone icon inside CircleAvatar
                    CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.mic),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return EmojiPicker(
      onEmojiSelected: (emoji, category) {
        print(emoji);
      },
    );
  }
}
