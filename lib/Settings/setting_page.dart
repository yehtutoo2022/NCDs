import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:ncd_myanmar/Page/favorite_page.dart';
import '../Page/bookmark_list.dart';
import 'about_app_screen.dart';
import 'dev_screen.dart';
import 'language_screen.dart';

class SettingsPage extends StatefulWidget {
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
        // leading: GestureDetector(
        //   child: const Icon(Icons.arrow_back_ios),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Container(
        color: Colors.brown[100],
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                Locales.string(context, "favorites"),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.medical_information),
              title: Text(
                Locales.string(context, "bmi"),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                );
              },
            ),
            const Divider(color: Colors.grey),
            // ListTile(
            //   title:  Text(
            //     Locales.string(context, "dark-mode"),
            //   ),
            //   onTap: () {
            //     // Navigate to the language selection screen
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ThemeScreen()),
            //     );
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(
                Locales.string(context, "bookmarks"),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  BookmarkScreen()),
                );
              },
            ),

            const SizedBox(height: 16), // Add space before the next ListTile
            const ListTile(
              title: Text('Settings',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(
                Locales.string(context, "change-language"),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Navigate to the language selection screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageScreen()),
                );
              },
            ),
            Divider(color: Colors.grey), // Black divider
            ListTile(
              leading: Icon(Icons.question_mark_outlined),
              title: Text(
                Locales.string(context, "about-app"),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Navigate to the language selection screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppScreen()),
                );
              },
            ),
            Divider(color: Colors.grey), // Black divider
            ListTile(
              leading: Icon(Icons.face),
              title: Text(
                Locales.string(context, "about-dev"),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeveloperProfileScreen()),
                );
              },
            ),
            Divider(color: Colors.grey), // Black divider
            // ListTile(
            //   title: Text(
            //     Locales.string(context, "theme"),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ThemeScreen()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
