import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
   late Color? selectedColor = Colors.brown[300];

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final colorHex = prefs.getString('selectedColor');
    if (colorHex != null) {
      setState(() {
        selectedColor = Color(int.parse(colorHex));
      });
    }
  }

   Future<void> _saveTheme(Color color) async {
     try {
       final prefs = await SharedPreferences.getInstance();
       await prefs.setString('selectedColor', color.value.toRadixString(16));
     } catch (e) {
       print('Error saving theme: $e');
     }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme"),
        backgroundColor: selectedColor,
      ),
      body: Container(
        color: selectedColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColorTile(Colors.brown[100]!),
              _buildColorTile(Colors.blue[300]!),
              _buildColorTile(Colors.blue[900]!),
              // Add more color tiles as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorTile(Color color) {
    return ListTile(
      title: Row(
        children: [
          Text(
            _getColorName(color),
            style: TextStyle(color: Colors.black), // Text color is black
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Black border
            ),
            child: Container(
              width: 24,
              height: 24,
              color: color,
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          selectedColor = color;
        });
        _saveTheme(color);
      },
    );
  }

  String _getColorName(Color color) {
    if (color == Colors.brown[100]) {
      return "Brown";
    } else if (color == Colors.blue[300]) {
      return "Aqua";
    } else if (color == Colors.blue[900]) {
      return "Deep Blue";
    } else {
      return "Unknown";
    }
  }
}
