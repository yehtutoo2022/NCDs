import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Diseases/asthma_page.dart';
import 'Diseases/breast_cancer.dart';
import 'Diseases/cancer_page.dart';
import 'Diseases/cervical_cancer_page.dart';
import 'Diseases/copd_page.dart';
import 'Diseases/diabetes_page.dart';
import 'Diseases/heart_disease_page.dart';
import 'Diseases/hypertension_page.dart';
import 'Diseases/lung_cancer_page.dart';
import 'Diseases/oral_cancer_page.dart';
import 'Diseases/seizures_page.dart';
import 'Diseases/stroke_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    initialization();
  }
  void initialization() async {
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final List<GridItem> gridItems = [
      GridItem(
        textKey: "hypertension",
        backgroundColor: Colors.white10,
        image: "assets/images/hypertension.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HypertensionScreen()),
          );

        },
        onLongPress: () {

        },
      ),
      GridItem(
        textKey: "diabetes",
        backgroundColor: Colors.white10,
        image: "assets/images/diabetes.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DiabetesScreen()),
          );
        },
        onLongPress: () {

        },
      ),
      GridItem(
        textKey: "heart-disease",
        backgroundColor: Colors.white10,
        image: "assets/images/heart-disease.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HeartDiseaseScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "stroke",
        backgroundColor: Colors.white10,
        image: "assets/images/stroke.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StrokeScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "cancer",
        backgroundColor: Colors.white10,
        image: "assets/images/cancer.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CancerScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "cervical-cancer",
        backgroundColor: Colors.white10,
        image: "assets/images/cervical-cancer.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CervicalCancerScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "oral-cancer",
        backgroundColor: Colors.white10,
        image: "assets/images/oral-cancer.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OralCancerScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "lung-cancer",
        backgroundColor: Colors.white10,
        image: "assets/images/lung-cancer.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LungCancerScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "breast-cancer",
        backgroundColor: Colors.white10,
        image: "assets/images/breast-cancer.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BreastCancerScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "copd",
        backgroundColor: Colors.white10,
        image: "assets/images/copd.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CopdScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "asthma",
        backgroundColor: Colors.white10,
        image: "assets/images/asthma.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AsthmaScreen()),
          );
        },
        onLongPress: () {
        },
      ),
      GridItem(
        textKey: "seizures",
        backgroundColor: Colors.white10,
        image: "assets/images/seizures.jpg",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SeizuresScreen()),
          );
        },
        onLongPress: () {
        },
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                Locales.string(context, "title"),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.brown[100],
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return GestureDetector(
                  onTap: gridItems[index].onPressed,
                  onLongPress: gridItems[index].onLongPress,
                  child: Card(
                    color: gridItems[index].backgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          gridItems[index].image,
                          width: double.infinity,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10.0),
                        Text(Locales.string(context, gridItems[index].textKey)),
                      ],
                    ),
                  ),
                );
              },
              childCount: gridItems.length,
            ),
          ),
        ],
      ),
    );
  }
}

class GridItem {
  final String textKey; // Use a key for the localized text instead of text
  final Color backgroundColor;
  final String image;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  GridItem({
    required this.textKey,
    required this.backgroundColor,
    required this.image,
    required this.onPressed,
    required this.onLongPress,
  });
}
