import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/article_model.dart';
import 'article_card.dart';
import 'bookmark_list.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late Future<List<Article>> _article;
  bool _isLoading = true;
  String _selectedCategory = 'All';
  List<String> _categories = ['All'];
  bool _isLoadingMore = false;
  int _currentPage = 1;
  final int _articlesPerPage = 10;
  List<Article> _allArticles = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _article = _loadCachedArticle();
    _scrollController.addListener(_scrollListener);
  }

  Future<List<Article>> _loadCachedArticle() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedArticle = prefs.getString('cached_article');

      if (cachedArticle != null) {
        List<dynamic> jsonList = jsonDecode(cachedArticle);
        List<Article> cachedArticleList = jsonList.map((e) => Article.fromJson(e)).toList();
        _updateCategories(cachedArticleList);
        setState(() {
          _isLoading = false;
        });
        return cachedArticleList;
      }
    } catch (e) {
      print('Error loading cached article: $e');
    }
    // If cached data not found or error occurred, fetch it from the network
    return _fetchArticle(1);
  }

  Future<List<Article>> _fetchArticle(int page) async {
    try {
      String githubRawUrl = 'https://raw.githubusercontent.com/yehtutoo2022/NCDs/master/assets/article_data.json';
      final response = await http.get(Uri.parse(githubRawUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Article> articleList = jsonList.map((e) => Article.fromJson(e)).toList();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('cached_article', jsonEncode(jsonList));

        _updateCategories(articleList);
        setState(() {
          _isLoading = false;
        });
        return articleList.skip((page - 1) * _articlesPerPage).take(_articlesPerPage).toList();
      } else {
        throw Exception('Failed to load article');
      }
    } catch (e) {
      print('Error loading article: $e');
      setState(() {
        _isLoading = false;
      });
      return [];
    }
  }

  void _updateCategories(List<Article> articles) {
    setState(() {
      _categories = ['All'] + articles.map((e) => e.category).toSet().toList();
      _categories.sort();
    });
  }

  Future<void> _refreshArticle() async {
    setState(() {
      //added
      _currentPage = 1;
      _allArticles.clear();

      _article = _fetchArticle(_currentPage);
    });
  }

  Future<void> _loadMoreArticles() async {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      List<Article> moreArticles = await _fetchArticle(_currentPage + 1);
      if (moreArticles.isNotEmpty) {
        setState(() {
          _currentPage++;
          _allArticles.addAll(moreArticles);
        });
      }
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _loadMoreArticles();
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _categories.map((String category) {
                return RadioListTile<String>(
                  title: Text(
                      category,
                      style: const TextStyle(fontSize: 14)
                  ),
                  value: category,
                  groupValue: _selectedCategory,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategory = value!;
                      Navigator.of(context).pop(); // Close the dialog
                    });
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Locales.string(context, "articles"),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.brown[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarkScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.brown[100],
      body: FutureBuilder<List<Article>>(
        future: _article,
        builder: (context, snapshot) {
          if (_isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading Articles...'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Please check your internet connection'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No articles found'),
            );
          } else {
            List<Article> articles = snapshot.data!;
            if (_currentPage == 1) {
              _allArticles = articles;
            } else {
              _allArticles.addAll(articles);
            }
            List<Article> filteredArticles = _selectedCategory == 'All'
                ? articles
                : articles.where((article) => article.category == _selectedCategory).toList();
            return RefreshIndicator(
              onRefresh: _refreshArticle,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: filteredArticles.length + (_isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == filteredArticles.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ArticleCard(article: filteredArticles[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}



