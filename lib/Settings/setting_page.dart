import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:ncd_myanmar/Page/Tool/bmi_calculator.dart';
import 'package:ncd_myanmar/Page/favorite_page.dart';
import 'package:ncd_myanmar/Settings/notifications_screen.dart';
import '../Page/bookmark_list.dart';
import 'about_app_screen.dart';
import 'dev_screen.dart';
import 'language_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool enableNotifications = true;
  bool enableDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Locales.string(context, "more"),
        ),
        backgroundColor: Colors.brown[100],
      ),
      body: Container(
        color: Colors.brown[100],
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(
                Locales.string(context, "notifications"),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(
                Locales.string(context, "favorites"),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: Text(
                Locales.string(context, "bookmarks"),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const BookmarkScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.medical_information),
              title: Text(
                Locales.string(context, "bmi"),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BMICalculatorScreen()),
                );
              },
            ),
            const SizedBox(height: 16), // Add space before the next ListTile
            const ListTile(
              title: Text('Settings',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(
                Locales.string(context, "change-language"),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Navigate to the language selection screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LanguageScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey), // Black divider
            ListTile(
              leading: const Icon(Icons.question_mark_outlined),
              title: Text(
                Locales.string(context, "about-app"),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Navigate to the language selection screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutAppScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey), // Black divider
            ListTile(
              leading: const Icon(Icons.face),
              title: Text(
                Locales.string(context, "about-dev"),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeveloperProfileScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey), // Black divider
          ],
        ),
      ),
    );
  }
}
