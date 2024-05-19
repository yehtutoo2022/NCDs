import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class AboutBMIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, "about-bmi")),
        backgroundColor: Colors.brown[100],
      ),
      backgroundColor: Colors.brown[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Locales.string(context, "about-bmi-title"),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20), // Add spacing between paragraphs
              Text(
                Locales.string(context, "about-bmi-p1"),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                Locales.string(context, "about-bmi-p2"),
                style: TextStyle(fontSize: 16),

              ),
              SizedBox(height: 20),
              Text(
                Locales.string(context, "about-bmi-p3"),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                Locales.string(context, "about-bmi-p4"),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
