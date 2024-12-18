import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String status;

  const ContactCard({
    super.key,
    required this.name,
    required this.avatar,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white12,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue.shade800,
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          status,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 230, 230, 230),
          ),
        ),
      ),
    );
  }
}
