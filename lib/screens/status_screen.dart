import 'package:chatapp/database/status.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // My Status Section
          ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(statusData[0]['image']!),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              statusData[0]['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(statusData[0]['time']!),
          ),
          const Divider(thickness: 1, color: Colors.grey),

          // Recent Updates Section
          Expanded(
            child: ListView.builder(
              itemCount: statusData.length - 1,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(statusData[index + 1]['image']!),
                  ),
                  title: Text(
                    statusData[index + 1]['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(statusData[index + 1]['time']!),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {},
            heroTag: "edit",
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.edit, color: Colors.black),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {},
            heroTag: "camera",
            backgroundColor: Colors.teal,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
