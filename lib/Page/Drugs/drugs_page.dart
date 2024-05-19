import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_locales/flutter_locales.dart';
import 'dart:convert';

import 'drugs_detail_page.dart';

class DrugsScreen extends StatefulWidget {
  @override
  _DrugsScreenState createState() => _DrugsScreenState();
}

class _DrugsScreenState extends State<DrugsScreen> {
  //variable data is the drugs list
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    loadJSONData().then((jsonData) {
      setState(() {
        data = jsonData;
        filteredData = List.from(data);
      });
    });
  }
  //data သည် list တခုအဖြစ်ထားပြီး Json data ကို loadJson function နှင့် ခေါ်ပြီး initState တွင် ထည့်

  //နှိပ်လိုက်သော drugs ရဲ့ detail ကို ပြ
  void goToDetailsScreen(Map<String, dynamic> drug) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrugDetailsScreen(drug),
      ),
    );
  }

//function for loading json data
  Future<List<Map<String, dynamic>>> loadJSONData() async {
    // Load the JSON data as a string from the 'assets/ncd_drugs.json' file
    final String jsonData = await rootBundle.loadString('assets/ncd_drugs.json');
    // Decode the JSON string into a List<Map<String, dynamic>> and return it
    return List<Map<String, dynamic>>.from(json.decode(jsonData));
  }

  void search(String query) {
    final filteredResults = searchItems(data, query);
    setState(() {
      filteredData = filteredResults;
    });
  }

  List<Map<String, dynamic>> searchItems(List<Map<String, dynamic>> data, String query) {
    query = query.toLowerCase();
    return data.where((item) {
      // Customize this based on your JSON structure and the field you want to search.
      final String itemName = item['Drugs Name'].toString().toLowerCase();
      return itemName.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Locales.string(context, "drugs"),
        ),
        backgroundColor: Colors.brown[100],
      ),
      body: Container(
        color: Colors.brown[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: search,
                decoration: InputDecoration(
                  label: Text(Locales.string(context, "search")),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final item = filteredData[index];
                  return GestureDetector(
                    onTap: () => goToDetailsScreen(item),
                    child: ListTile(
                      title: Text(item['Drugs Name'].toString()),
                      subtitle: Text(item['Category'].toString()),
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
