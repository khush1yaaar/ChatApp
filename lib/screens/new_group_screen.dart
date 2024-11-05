import 'package:chatapp/database/contacts.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/widgets/contact_card.dart'; // Import your ContactCard widget

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  // List to keep track of selected contacts
  List<ChatModel> selectedContacts = [];

  // Toggle selection of a contact
  void toggleSelection(ChatModel contact) {
    setState(() {
      if (selectedContacts.contains(contact)) {
        selectedContacts.remove(contact);
      } else {
        selectedContacts.add(contact);
      }
    });
  }

  // Clear all selections
  void clearSelection() {
    setState(() {
      selectedContacts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
        actions: [
          if (selectedContacts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: clearSelection,
              tooltip: "Clear All",
            ),
        ],
      ),
      body: Column(
        children: [
          // Display selected contacts
          if (selectedContacts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: selectedContacts.map((contact) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueAccent,
                        backgroundImage: AssetImage(contact.icon), // Load icon as an image
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          const Divider(),
          // Contact list with additional data display
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                final isSelected = selectedContacts.contains(contact);

                return GestureDetector(
                  onTap: () => toggleSelection(contact),
                  child: Stack(
                    children: [
                      ContactCard(
                        name: contact.name,
                        avatar: contact.icon,
                        status: contact.currentMessage, // Using `currentMessage` as the status
                      ),
                      if (isSelected)
                        Positioned(
                          right: 16,
                          top: 16,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Confirm Button
          if (selectedContacts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Group created with ${selectedContacts.length} members!"),
                    ),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text("Confirm Selection"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
