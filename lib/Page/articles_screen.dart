import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/article_model.dart';
import 'article_detail_screen.dart';
import 'bookmark_list.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late Future<List<Article>> _article;
  bool _isLoading = true;
  String _selectedCategory = 'All';
  List<String> _categories = ['All']; // Initial category list

  @override
  void initState() {
    super.initState();
    _article = _loadCachedArticle();
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
    return _fetchArticle();
  }

  Future<List<Article>> _fetchArticle() async {
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
        return articleList;
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
    });
  }

  Future<void> _refreshArticle() async {
    setState(() {
      _article = _fetchArticle();
    });
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
                  title: Text(category),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Locales.string(context, "articles"),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.brown[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog, // Show filter dialog on tap
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
            List<Article> filteredArticles = _selectedCategory == 'All'
                ? articles
                : articles.where((article) => article.category == _selectedCategory).toList();
            return RefreshIndicator(
              onRefresh: _refreshArticle,
              child: ListView.builder(
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
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

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailScreen(article: article),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  placeholder: (context, url) => Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey,
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey,
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

