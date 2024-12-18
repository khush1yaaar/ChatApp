import 'package:chatapp/constants/theme/themes.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/screens/all_chats_screen.dart';
import 'package:chatapp/screens/calls_screen.dart';
import 'package:chatapp/screens/settings_screen.dart';
import 'package:chatapp/screens/starred_messages_screen.dart';
import 'package:chatapp/screens/status_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen(this.chats, this.sourceChat, {super.key});
  late List<ChatModel> chats;
  late ChatModel sourceChat;
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
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            currentTheme.homeBg,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150), // Adjust this size
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ensure the app bar doesn't overflow
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
                              icon: _buildFloatingIcon(Icons
                                  .more_vert), // Use your floating icon method
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                const PopupMenuItem(
                                  value: 'newgroup',
                                  child: Text('New Group'),
                                ),
                                const PopupMenuItem(
                                  value: 'starred',
                                  child: Text('Starred'),
                                ),
                                const PopupMenuItem(
                                  value: 'settings',
                                  child: Text('Settings'),
                                ),
                              ],
                              onSelected: (value) {
                                // Handle the selection
                                if (value == 'settings') {
                                  // Navigate to settings or perform actions
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsScreen()),
                                  );
                                } else if (value == 'starred') {
                                  // Perform logout action
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StarredMessagesScreen()),
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
                  const SizedBox(height: 20),
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
                    children: [
                      AllChatsScreen(chatModels: widget.chats, sourcechat: widget.sourceChat,),
                      const StatusScreen(),
                      const CallsScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(21, 101, 192, 1),
          ),
          indicatorPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: -35.0),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black54,
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
          // This removes the default underline of TabBar
          //indicatorWeight: 0,
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
