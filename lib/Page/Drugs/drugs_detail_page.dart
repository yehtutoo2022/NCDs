import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DrugDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> drug;


  DrugDetailsScreen(this.drug);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, "drug-detail")),
        backgroundColor: Colors.brown[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drug['Drugs Name'],
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  //details of each drug
                  //title type
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.0), // Add spacing between the icon and text
                      AutoSizeText(
                        maxLines: 2,
                        "Type",
                        minFontSize: 16,
                        maxFontSize: 28,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // from JSON
                  Text(
                    '${drug['Type']}',
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 30.0),
                  //title
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red,
                      ), // Replace with the icon you want
                      SizedBox(width: 5.0), // Add spacing between the icon and text
                      AutoSizeText(
                        maxLines: 2,
                        "Ingredients",
                        minFontSize: 16,
                        maxFontSize: 28,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //from JSON
                  Text(
                    'Ingredients: ${drug['Ingredients']}',
                    style: const TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 30.0),
                  //title
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red,
                      ), // Replace with the icon you want
                      SizedBox(width: 5.0), // Add spacing between the icon and text
                      AutoSizeText(
                        maxLines: 2,
                        "Category",
                        minFontSize: 16,
                        maxFontSize: 28,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //from JSON
                  Text(
                    'Category: ${drug['Category']}',
                    style: const TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red,
                      ), // Replace with the icon you want
                      SizedBox(width: 5.0), // Add spacing between the icon and text
                      AutoSizeText(
                        maxLines: 2,
                        "Class",
                        minFontSize: 16,
                        maxFontSize: 28,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Class: ${drug['Class']}',
                    style: const TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red,
                      ), // Replace with the icon you want
                      SizedBox(width: 5.0), // Add spacing between the icon and text
                      AutoSizeText(
                        maxLines: 2,
                        "Indications",
                        minFontSize: 16,
                        maxFontSize: 28,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Indications: ${drug['Indications']}',
                    style: const TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red,
                      ), // Replace with the icon you want
                      SizedBox(width: 5.0), // Add spacing between the icon and text
                      AutoSizeText(
                        maxLines: 2,
                        "Manufacturer",
                        minFontSize: 16,
                        maxFontSize: 28,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Manufacturer: ${drug['Manufacturer']}',
                    style: const TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.red,
                      ), // Replace with the icon you want
                      SizedBox(width: 5.0), // Add spacing between the icon and text
                      AutoSizeText(
                        maxLines: 2,
                        "Price",
                        minFontSize: 16,
                        maxFontSize: 28,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Price: ${drug['Price']}',
                    style: const TextStyle(fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
