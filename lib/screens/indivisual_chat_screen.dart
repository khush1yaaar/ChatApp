import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/screens/profile_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IndivisualChatScreen extends StatefulWidget {
  IndivisualChatScreen({super.key, required this.chatmodel});
  ChatModel chatmodel;

  @override
  State<IndivisualChatScreen> createState() => _IndivisualChatScreenState();
}

class _IndivisualChatScreenState extends State<IndivisualChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leadingWidth: 100,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueGrey,
              child: widget.chatmodel.isGroup
                  ? const Icon(Icons.group, color: Colors.white,)
                  : const Icon(Icons.person, color: Colors.white,),
            )
          ],
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatmodel.name,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'last seen today at ${widget.chatmodel.time}',
                style: const TextStyle(
                    color: Color.fromARGB(255, 209, 209, 209), fontSize: 12),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.videocam,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Colors.white,
              )),
          PopupMenuButton(
            color: const Color.fromARGB(255, 255, 255, 255),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ), // Use your floating icon method
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem(
                value: 'newgroup',
                child: Text('New Group'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'starred',
                child: Text('Starred'),
              ),
            ],
            onSelected: (value) {
              // Handle the selection
              if (value == 'settings') {
                // Navigate to settings or perform actions
              } else if (value == 'profile') {
                // Perform logout action

                print('Profile Selected');
              } else if (value == 'starred') {
                // Perform logout action

                print('Starred selected');
              }
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
