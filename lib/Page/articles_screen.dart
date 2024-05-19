import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ncd_myanmar/Page/article_detail_screen.dart';
import 'package:ncd_myanmar/model/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {

  late Future<List<Article>> _article;
  bool _isLoading = true;

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
      String githubRawUrl = '';
      final response = await http.get(Uri.parse(githubRawUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Article> articleList = jsonList.map((e) => Article.fromJson(e)).toList();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('cached_article', jsonEncode(jsonList));

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

  Future<void> _refreshArticle() async {
    setState(() {
      _article = _fetchArticle();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Articles',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      //FutureBuilder is to show loading indicator while fetching from internet
      body: FutureBuilder<List<Article>>(
        future: _article,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
          } else {
            List<Article>? article = snapshot.data;
            return RefreshIndicator(
              onRefresh: _refreshArticle,
              child: ListView.builder(
                itemCount: article?.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ArticleDetailScreen(article: article[index]),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                article![index].imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 200),
                              ListTile(
                                contentPadding: EdgeInsets.all(10),
                                title: Text(
                                  article[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ArticleDetailScreen(article: article[index]),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

                },
              ),
            );

          }
        },
      ),
    );
  }
}