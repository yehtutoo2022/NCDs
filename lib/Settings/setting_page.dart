import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:ncd_myanmar/Settings/theme_screen.dart';
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
          Locales.string(context, "setting"),
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
              title: Text(
                Locales.string(context, "notifications"),
              ),
              trailing: Switch(
                value: enableNotifications,
                onChanged: (value) {
                  setState(() {
                    enableNotifications = value;
                  });
                },
              ),
            ),
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
              title: Text(
                Locales.string(context, "change-language"),
              ),
              onTap: () {
                // Navigate to the language selection screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                Locales.string(context, "about-app"),
              ),
              onTap: () {
                // Navigate to the language selection screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                Locales.string(context, "about-dev"),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeveloperProfileScreen()),
                );
              },
            ),
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
