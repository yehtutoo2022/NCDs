import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
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

  double _expansionTitleFontSize = 16.0;
  double _expansionSubtitleFontSize = 14.0;
  double minFontSize = 12.0;
  double maxFontSize = 24.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
      isBookmark = bookmarkProvider.isBookmark(widget.article);

    });
  }
  void _increaseExpansionFontSize() {
    setState(() {
      _expansionTitleFontSize += 2.0;
      _expansionSubtitleFontSize +=2.0;
      // Limit maximum font size
      if (_expansionTitleFontSize > maxFontSize) {
        _expansionTitleFontSize = maxFontSize;
      }
      if (_expansionSubtitleFontSize > maxFontSize) {
        _expansionSubtitleFontSize = maxFontSize;
      }

    });
  }
  void _decreaseExpansionFontSize() {
    setState(() {
      _expansionTitleFontSize -= 2.0;
      _expansionSubtitleFontSize -=2.0;

      // Limit minimum font size
      if (_expansionTitleFontSize < minFontSize) {
        _expansionTitleFontSize = minFontSize;
      }
      if (_expansionSubtitleFontSize < minFontSize) {
        _expansionSubtitleFontSize = minFontSize;
      }

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
        backgroundColor: Colors.brown[100],
        actions: [
          Consumer<BookmarkProvider>(
          builder: (context, bookmarkProvider, _) {
            bool isBookmark = bookmarkProvider.isBookmark(widget.article);
            return IconButton(
              icon: Icon(
                isBookmark ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmark ? Colors.red : null,
              ),
              onPressed: toggleBookmark,
            );
          },
        ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.zoom_in),
                  title: Text(Locales.string(context, "font-increase")),
                  onTap: _increaseExpansionFontSize,
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.zoom_out),
                  title: Text(Locales.string(context, "font-decrease")),
                  onTap: _decreaseExpansionFontSize,
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.brown[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              // child: Image.network(
              //   widget.article.imageUrl,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: widget.article.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey, // or any other placeholder design you prefer
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey, // or any other error widget you prefer
                  child: Icon(Icons.error, color: Colors.white), // optional error icon
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: double.infinity, // Ensures the container takes up the full width
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color
                  borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                ),
                child: Center(
                  child: Text(
                    widget.article.title,
                    style: TextStyle(
                        fontSize: _expansionTitleFontSize,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
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
                style: TextStyle(fontSize: _expansionTitleFontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP1Sub,
                style: TextStyle(fontSize: _expansionSubtitleFontSize),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP2,
                style: TextStyle(fontSize: _expansionTitleFontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP2Sub,
                style: TextStyle(fontSize: _expansionSubtitleFontSize),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP3,
                style: TextStyle(fontSize:_expansionTitleFontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP3Sub,
                style: TextStyle(fontSize: _expansionSubtitleFontSize),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP4,
                style: TextStyle(fontSize: _expansionTitleFontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP4Sub,
                style:  TextStyle(fontSize: _expansionSubtitleFontSize),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP5,
                style:  TextStyle(fontSize: _expansionTitleFontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.article.contentP5Sub,
                style:  TextStyle(fontSize: _expansionSubtitleFontSize),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
