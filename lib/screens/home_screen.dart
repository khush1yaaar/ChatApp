import 'package:chatapp/screens/all_chats_screen.dart';
import 'package:chatapp/screens/calls_screen.dart';
import 'package:chatapp/screens/profile_screen.dart';
import 'package:chatapp/screens/settings_screen.dart';
import 'package:chatapp/screens/starred_messages_screen.dart';
import 'package:chatapp/screens/status_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Adjust this size
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure the app bar doesn't overflow
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hello, Khushi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        _buildFloatingIcon(Icons.search),
                        const SizedBox(width: 10),
                        PopupMenuButton(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          icon: _buildFloatingIcon(
                              Icons.more_vert), // Use your floating icon method
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingsScreen()),
                              );
                            } 
                            else if (value == 'profile') {
                              // Perform logout action
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfileScreen()),
                              );
                              print('Profile Selected');
                            }
                            else if (value == 'starred') {
                              // Perform logout action
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StarredMessagesScreen()),
                              );
                              print('Starred selected');
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildFloatingTabBar(),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AllChatsScreen(),
                  StatusScreen(),
                  CallsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Floating Icon (white bubble)
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

  Widget _buildFloatingTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0), // Added padding
        child: TabBar(
          controller: _tabController,
          // Increase the height of the indicator and match it with the tab height
          indicator: BoxDecoration(
            borderRadius:
                BorderRadius.circular(30), // Match this with outer container
            color: Colors.blue.shade800, // Color for selected tab
          ),
          indicatorPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: -30.0),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black54,
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
          tabs: const [
            Tab(text: 'All Chats'),
            Tab(text: '  Status  '),
            Tab(text: '   Calls   '),
          ],
        ),
      ),
    );
  }
}
