import 'package:flutter/material.dart';
import 'package:ncd_myanmar/Page/articles_screen.dart';
import 'package:ncd_myanmar/Page/video_screen.dart';
import 'Page/home_page.dart';
import 'Settings/notifications_screen.dart';
import 'Settings/setting_page.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ArticleScreen(),
    VideoScreen(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey, // Color for unselected items (icon and label)
        selectedItemColor: Colors.red, // Color for selected items (icon and label)
        backgroundColor: Colors.brown[100],
      ),
    );
  }
}
