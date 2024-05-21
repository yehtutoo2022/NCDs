import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:ncd_myanmar/model/article_model.dart';
import 'package:provider/provider.dart';

import '../model/bookmark_provider.dart';
import 'article_detail_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Article> bookmarkedArticle = Provider.of<BookmarkProvider>(context).bookmark;

    void removeBookmark(Article article) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove from Bookmarks'),
            content: Text('Are you sure you want to remove this article from bookmarks?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<BookmarkProvider>(context, listen: false).deleteBookmark(article);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Article removed from bookmarks'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Remove'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Locales.string(context, "bookmarks"),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[100],
      ),
      backgroundColor: Colors.brown[100],
      body: bookmarkedArticle.isEmpty
          ? const Center(
        child: Text('No bookmarks yet.'),
      )
          : ListView.builder(
        itemCount: bookmarkedArticle.length,
        itemBuilder: (context, index) {
          final Article article = bookmarkedArticle[index];
          return ListTile(
            title: Text(article.title),
            subtitle: Text(article.source),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(article: article),
                ),
              );
            },
            onLongPress: () {
              removeBookmark(article);
            },
          );
        },
      ),
    );
  }
}
