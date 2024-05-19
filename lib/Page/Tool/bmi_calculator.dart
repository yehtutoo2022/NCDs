import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'about_bmi.dart';


class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {


  bool isMetric = false;
  double heightCm = 0;
  double heightFt = 0;
  double heightIn = 0;
  double weightKg = 0;
  double weightLb = 0;
  double bmi = 0;
  String bmiClassification = '';
  Color bmiColor = Colors.black;

  void calculateBMI() {
    setState(() {
      if (isMetric) {
        bmi = weightKg / ((heightCm / 100) * (heightCm / 100));
      } else {
        final totalInches = heightFt * 12 + heightIn;
       // final weightLbs = weight * 2.20462; // Convert kg to lbs
       // bmi = ((weight *2.204623)/ (totalInches * totalInches)) * 703;
        bmi = (weightLb / (totalInches * totalInches)) * 703;
      }

      if (bmi < 18.5) {
        bmiClassification = Locales.string(context, "bmi-under");
        bmiColor = Colors.blue;
      } else if (bmi < 24.9) {
        bmiClassification = Locales.string(context, "bmi-normal");
        bmiColor = Colors.green;
      } else if (bmi < 29.9) {
        bmiClassification = Locales.string(context, "bmi-over");
        bmiColor = Colors.orange;
      } else {
        bmiClassification = Locales.string(context, "bmi-obese");
        bmiColor = Colors.red;
      }
    });
  }

  Container _buildIndicator(double bmi) {
    Color color;
    if (bmi < 18.5) {
      color = Colors.blue; // Underweight
    } else if (bmi < 25) {
      color = Colors.green; // Normal weight
    } else if (bmi < 30) {
      color = Colors.orange; // Overweight
    } else {
      color = Colors.red; // Obese
    }

    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 8, color: color),
      ),
      alignment: Alignment.center,
      child: Text(
        bmi.toStringAsFixed(1),
        style: TextStyle(fontSize: 48, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Locales.string(context, "bmi")
        ),
        backgroundColor: Colors.brown[100],
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutBMIScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.brown[100],

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Text(
                Locales.string(context, "enter-wt-ht"),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Imperial'),
                  Switch(
                    value: isMetric,
                    onChanged: (value) {
                      setState(() {
                        isMetric = value;
                      });
                    },
                  ),
                  const Text('Metric'),
                ],
              ),
              isMetric
                  ? Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    onChanged: (value) {
                      setState(() {
                        heightCm = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ],
              )
                  : Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Height (ft)'),
                    onChanged: (value) {
                      setState(() {
                        heightFt = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Height (in)'),
                    onChanged: (value) {
                      setState(() {
                        heightIn = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: isMetric ? 'Weight (kg)' : 'Weight (lbs)',
                ),
                onChanged: (value) {
                  setState(() {
                    weightLb = double.tryParse(value) ?? 0;
                    weightKg = double.tryParse(value) ?? 0;
                  });
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Hide the keyboard
                  FocusScope.of(context).unfocus();
                  calculateBMI();
                },
                child:Text(Locales.string(context, "calculate-bmi")),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              _buildIndicator(bmi),
              const SizedBox(height: 20),
              Text(
                Locales.string(context, "your-bmi") + ': ${bmi.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                Locales.string(context, "classification") + ': $bmiClassification',
                style: TextStyle(fontSize: 18, color: bmiColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
