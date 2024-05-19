import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ncd_myanmar/model/article_model.dart';
import 'package:provider/provider.dart';

import '../model/bookmark_provider.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  ArticleDetailScreen({required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  late BookmarkProvider bookmarkProvider;
  bool isBookmark = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
      isBookmark = bookmarkProvider.isBookmark(widget.article);

    });
  }

  void toggleBookmark() {
 //   Vibration.vibrate(duration: 100);

    setState(() {
      isBookmark = !isBookmark;
    });
    bookmarkProvider.toggleBookmark(widget.article);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isBookmark ? 'Added to bookmark' : 'Remove from bookmark'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.article.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                widget.article.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Source: ${widget.article.source}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP1,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP2,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP3,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP4,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP5,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
