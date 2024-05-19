import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DeveloperProfileScreen extends StatefulWidget {
  const DeveloperProfileScreen({Key? key}) : super(key: key);

  @override
  _DeveloperProfileScreenState createState() => _DeveloperProfileScreenState();
}

class _DeveloperProfileScreenState extends State<DeveloperProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, "about-dev")),
        backgroundColor: Colors.brown[100],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [

              SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Ye Htut Oo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Flutter Development for Health, Fitness and Education',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              //grey color
              Text(
                'Contact me : Mr.YeHutOo@outlook.com',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 20),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     Locales.string(context, "about-dev-detail1"),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 16),
              //   ),
              // ),
              SizedBox(height: 10),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     Locales.string(context, "about-dev-detail2"),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 16),
              //   ),
              // ),
              SizedBox(height: 10),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     Locales.string(context, "about-dev-detail3"),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 16),
              //   ),
              // ),
              SizedBox(height: 10),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     Locales.string(context, "about-dev-detail4"),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 16),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

