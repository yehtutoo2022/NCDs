import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../model/favorite_model.dart';
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

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, "favorites")),
        backgroundColor: Colors.brown[100],
      ),
      backgroundColor: Colors.brown[100],
      body: Consumer<FavoriteDataModel>(
        builder: (context, favoriteData, _) {
          return ListView.builder(
            itemCount: favoriteData.favorites.length,
            itemBuilder: (context, index) {
              final item = favoriteData.favorites[index];
              return ListTile(
                title: Text(Locales.string(context, item.toLowerCase())),
                onTap: () {
                  // Navigate to the corresponding screen based on the item clicked
                  if (item == 'Hypertension') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HypertensionScreen(),
                      ),
                    );
                  } else if (item == 'Heart-Disease') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HeartDiseaseScreen(),
                      ),
                    );
                  } else if (item == 'Diabetes') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DiabetesScreen(),
                      ),
                    );
                  } else if (item == 'Stroke') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StrokeScreen(),
                      ),
                    );
                  } else if (item == 'Cancer') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CancerScreen(),
                      ),
                    );
                  } else if (item == 'Cervical-Cancer') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CervicalCancerScreen(),
                      ),
                    );

                  } else if (item == 'Lung-Cancer') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LungCancerScreen(),
                      ),
                    );

                  } else if (item == 'Oral-Cancer') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OralCancerScreen(),
                      ),
                    );

                  } else if (item == 'Breast-Cancer') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BreastCancerScreen(),
                      ),
                    );
                  } else if (item == 'Asthma') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AsthmaScreen(),
                      ),
                    );
                  } else if (item == 'Copd') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CopdScreen(),
                      ),
                    );
                  } else if (item == 'Copd') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SeizuresScreen(),
                      ),
                    );

                  }
                  // Add more conditions for other screens if needed
                },
                trailing: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red, // Change the color to red
                  ),
                  onPressed: () {
                    Provider.of<FavoriteDataModel>(context, listen: false)
                        .removeFavorite(item);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
