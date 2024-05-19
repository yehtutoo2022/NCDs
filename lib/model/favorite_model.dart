import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoriteDataModel extends ChangeNotifier {
  List<String> _favorites = [];

  // Getter for favorites
  List<String> get favorites => _favorites;

  FavoriteDataModel() {
    // Load favorites from shared preferences when the class is instantiated
    _loadFavorites();
  }

  // Add a favorite
  void addFavorite(String favorite) {
    _favorites.add(favorite);
    _saveFavorites(); // Save favorites after adding
    notifyListeners(); // Notify listeners that the data has changed
  }

  // Remove a favorite
  void removeFavorite(String favorite) {
    _favorites.remove(favorite);
    _saveFavorites(); // Save favorites after removal
    notifyListeners(); // Notify listeners that the data has changed
  }

  // Load favorites from shared preferences
  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners(); // Notify listeners that the data has changed
  }

  // Save favorites to shared preferences
  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites);
  }
}


