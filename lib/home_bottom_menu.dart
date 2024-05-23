// import 'package:flutter/material.dart';
// import 'package:ncd_myanmar/Page/articles_screen.dart';
// import 'package:ncd_myanmar/Page/video_screen.dart';
// import 'Page/all_ncd_page.dart';
// import 'Settings/setting_page.dart';
//
// class HomeMenu extends StatefulWidget {
//   const HomeMenu({super.key});
//
//   @override
//   State<HomeMenu> createState() => _HomeMenuState();
// }
//
// class _HomeMenuState extends State<HomeMenu> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     ArticleScreen(),
//     VideoScreen(),
//     const SettingsPage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex], // Display the selected screen
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.newspaper),
//             label: 'Articles',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.ondemand_video_outlined),
//             label: 'Videos',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu),
//             label: 'More',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         unselectedItemColor: Colors.grey,
//         selectedItemColor: Colors.red,
//         backgroundColor: Colors.brown[100],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ncd_myanmar/Page/articles_screen.dart';
import 'package:ncd_myanmar/Page/video_screen.dart';
import 'Page/all_ncd_page.dart';
import 'Settings/setting_page.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const HomeScreen(),
    ArticleScreen(),
    VideoScreen(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
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
            icon: Icon(Icons.ondemand_video_outlined),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        backgroundColor: Colors.brown[100],
      ),
    );
  }
}
