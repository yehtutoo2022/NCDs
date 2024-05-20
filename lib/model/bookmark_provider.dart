import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ncd_myanmar/model/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider with ChangeNotifier {
  Set<Article> _bookmark = {};
  SharedPreferences? _prefs;

  BookmarkProvider() {
    _loadBookmark();
  }

  List<Article> get bookmark => _bookmark.toList();

  void toggleBookmark(Article article) {
    if (_bookmark.contains(article)) {
      _bookmark.remove(article);
    } else {
      _bookmark.add(article);
    }
    _saveBookmark();
    notifyListeners();
  }

  bool isBookmark(Article article) {
    return _bookmark.contains(article);
  }

  Future<void> _loadBookmark() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? bookmarkJson = _prefs?.getStringList('bookmark');
    if (bookmarkJson != null) {
      _bookmark = bookmarkJson.map((json) => Article.fromJson(jsonDecode(json))).toSet();
    }
  }

  void _saveBookmark() {
    final List<String> bookmarkJson = _bookmark.map((drug) => jsonEncode(drug.toJson())).toList();
    _prefs?.setStringList('bookmark', bookmarkJson);
  }

  void clearAllBookmark() {
    _bookmark.clear();
    _saveBookmark();
    notifyListeners();
  }

  void deleteSelectedBookmark (Set<Article> article) {
    _bookmark.removeAll(article);
    _saveBookmark();
    notifyListeners();
  }

  void deleteBookmark (Article article) {
    _bookmark.remove(article);
    _saveBookmark();
    notifyListeners();
  }
}
