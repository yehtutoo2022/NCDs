import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DrugsJsonScreen extends StatefulWidget {
  @override
  _DrugsJsonScreenState createState() => _DrugsJsonScreenState();
}

class _DrugsJsonScreenState extends State<DrugsJsonScreen> {
  List<dynamic> data = [];
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('isFirstTime') ?? true;

    final file = File('${(await getApplicationDocumentsDirectory()).path}/ncd_drugs.json');

    if (await file.exists()) {
      final jsonData = await file.readAsString();
      setState(() {
        data = json.decode(jsonData);
      });
    } else {
      final response = await http.get(Uri.parse('https://drive.google.com/uc?export=download&id=1kGZWVeMAPdqRhWWsrvqPg1lYUUm7TnHz'));

      if (response.statusCode == 200) {
        await file.writeAsString(response.body);
        setState(() {
          data = json.decode(response.body);
        });

        if (isFirstTime) {
          // Show dialog for the first time only
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Data Downloaded'),
                content: const Text('The JSON data has been downloaded from the internet.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          // Update the flag indicating that the file has been downloaded
          prefs.setBool('isFirstTime', false);
        }
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('JSON Data Example'),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text(item['Drugs Name']),
              subtitle: Text('Category: ${item['Category']}'),
            );
          },
        ),
      );
    }
  }
}
