import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
        backgroundColor: Colors.brown[100],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/splash.png'),
                ),
                const SizedBox(height: 10),


                // const Text(
                //   "App Name: Non-Communicable Diseases",
                //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 10),
                const Text(
                  "Version: 1.3.0",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  Locales.string(context, "about-app-description"),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Text(
                  Locales.string(context, "about-app-reference"),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Text(
                  Locales.string(context, "about-app-images"),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Contact Me:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Email: mr.yehtutoo2016@gmail.com",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Website: www.yho-apps.com",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


