import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  void _showLanguageChangedSnackBar(BuildContext context, String language) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed to $language'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  void _showLanguageChangedBurmese(BuildContext context, String language) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('မြန်မာဘာသာသို့ ပြောင်းပြီးပြီ'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(Locales.string(context, 'setting')),
        backgroundColor: Colors.brown[100],
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Locales.change(context, 'en');
              _showLanguageChangedSnackBar(context, 'English');
            },
            title: const LocaleText('english'),
          ),
          ListTile(
            onTap: () {
              Locales.change(context, 'my');
              _showLanguageChangedBurmese(context, 'မြန်မာ');
            }, // Add this line for Burmese (Myanmar)
            title: const LocaleText('burmese'), // Add this line for Burmese (Myanmar)
          ),
          //  Text('Current Locale: ' + Locales.currentLocale(context)!.languageCode),
        ],
      ),
    );
  }
}
