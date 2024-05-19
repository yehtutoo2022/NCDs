import 'package:flutter/material.dart';
import 'Page/Drugs/drugs_page.dart';
import 'Page/Drugs/drugs_json.dart';
import 'Page/Tool/bmi_calculator.dart';
import 'Page/favorite_page.dart';
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
    //TestFavoritesScreen,
    // ReminderListScreen(reminders: reminders),
   // AboutAppScreen(),
   // FavoriteScreenPage(),
    FavoriteScreen(),
    BMICalculatorScreen(),
   // Drugs_JsonScreen(),
    SettingsPage(),
   // FavoriteDrugsScreen(),
  //  StretchableSliverAppBar(),
  //  ReminderScreen(),
   // MedicineHomePage()

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
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded),
            label: 'Tool',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
