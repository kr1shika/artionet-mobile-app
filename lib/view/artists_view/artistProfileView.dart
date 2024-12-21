import 'package:flutter/material.dart';
import 'package:tryproject/view/artists_view/chatbox.dart';
import 'package:tryproject/view/artists_view/notificationView.dart';
import 'package:tryproject/view/artists_view/settingsview.dart';

class Artistprofileview extends StatefulWidget {
  const Artistprofileview({super.key});

  @override
  State<Artistprofileview> createState() => _ArtistprofileviewState();
}

class _ArtistprofileviewState extends State<Artistprofileview> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    SingleChildScrollView(
      child: Stack(
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/krishika.jpg',
            height: 140,
            width: 412,
            fit: BoxFit.cover,
          ),
        ],
      ),
    ),
    const ChatboxView(),
    const NotificationView(),
    const SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFF7),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 43,
          fit: BoxFit.contain,
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      ),
    );
  }
}
