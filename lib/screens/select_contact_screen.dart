import 'package:chatapp/constants/theme/themes.dart';
import 'package:chatapp/database/contacts.dart';
import 'package:chatapp/screens/new_group_screen.dart';
import 'package:chatapp/widgets/chat_cards/contact_card.dart';
import 'package:flutter/material.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({super.key});

  @override
  State<SelectContactScreen> createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  // Sample list of contacts

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            currentTheme.contactBg,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "Select Contact",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: currentTheme.themeData.scaffoldBackgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.white), // Back arrow made white
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                //color: Colors.white,
                onSelected: (value) {
                  // Handle menu selection
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: "Invite a friend",
                      child: Text("Invite a friend"),
                    ),
                    const PopupMenuItem(
                      value: "Contacts",
                      child: Text("Contacts"),
                    ),
                    const PopupMenuItem(
                      value: "Refresh",
                      child: Text("Refresh"),
                    ),
                    const PopupMenuItem(
                      value: "Help",
                      child: Text("Help"),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "New Contacts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewGroupScreen()));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade800,
                    child: const Icon(Icons.group, color: Colors.white),
                  ),
                  title: const Text(
                    "New Group",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade800,
                  child: const Icon(Icons.person_add, color: Colors.white),
                ),
                title: const Text(
                  "New Contact",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Contacts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return ContactCard(
                        name: contacts[index].name,
                        avatar: "lib/const/images/person.svg",
                        status: contacts[index].about);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
