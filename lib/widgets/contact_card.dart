import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: SvgPicture.asset(
            avatar,
            fit: BoxFit.cover,
            height: 32,
            width: 32,
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
            color: Colors.blueGrey,
          ),
        ),
        // trailing: const Icon(
        //   Icons.chevron_right,
        //   color: Colors.blueGrey,
        // ),
      ),
    );
  }
}
