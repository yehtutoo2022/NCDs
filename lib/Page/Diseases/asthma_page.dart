import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../../model/favorite_provider.dart';

import 'dart:typed_data';

class AsthmaScreen extends StatefulWidget {
  const AsthmaScreen({super.key,});

  @override
  State<AsthmaScreen> createState() => _AsthmaScreenState();
}

class _AsthmaScreenState extends State<AsthmaScreen> {
  bool isBookmarked = false;
  final List<bool> _isExpandedList = [false, false, false];
  double _expansionTitleFontSize = 16.0;
  double _expansionSubtitleFontSize = 14.0;
  double minFontSize = 12.0;
  double maxFontSize = 24.0;

  @override
  void initState() {
    super.initState();
    isBookmarked = Provider.of<FavoriteProvider>(context, listen: false)
        .favorites
        .contains('Asthma');
  }
  void _toggleFavorite() {
    setState(() {
      isBookmarked = !isBookmarked;
      if (isBookmarked) {
        // Add item to favorites list
        Provider.of<FavoriteProvider>(context, listen: false).addFavorite('Asthma');
      } else {
        // Remove item from favorites list
        Provider.of<FavoriteProvider>(context, listen: false).removeFavorite('Asthma');
      }
    });
    String message =
    isBookmarked ? 'Added to Favorites' : 'Removed from Favorites';
    _showSnackbar(context, message);
  }
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }
  void _changeEngLanguage(BuildContext context, Locale newLocale) {
    Locales.change(context, 'en');
    _showSnackbar(context, 'Language changed to English');
  }
  void _changeMyanLanguage(BuildContext context, Locale newLocale) {
    Locales.change(context, 'my');
    _showSnackbar(context, 'မြန်မာဘာသာသို့ပြောင်းပြီး');
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.brown[100],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            backgroundColor: Colors.brown[100],
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(Locales.string(context, "asthma")),
              background: Image.asset('assets/images/asthma.jpg', fit: BoxFit.cover),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.favorite : Icons.favorite_border,
                  color: isBookmarked ? Colors.red : null, // Set color to red if bookmarked, null otherwise
                ),
                onPressed: _toggleFavorite,
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: Text('English'),
                      onTap: () {
                        _changeEngLanguage(context, const Locale('en'));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: Text('မြန်မာ'),
                      onTap: () {
                        _changeMyanLanguage(context, const Locale('my'));
                        Navigator.pop(context);
                      },
                    ),
                  ),
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          Locales.string(context, "asthma-detail"),
                          style:  TextStyle(
                            fontSize: _expansionTitleFontSize,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      //paragraph 1
                      _buildExpansionTile(
                        0,
                      //  Icons.check_circle_rounded,
                        Locales.string(context, "asthma-p1-title"),
                        'https://chicagoent.com/wp-content/uploads/shutterstock_1795482571-1024x588.jpg',
                        Locales.string(context, "asthma-p1-detail"),
                      ),
                      const SizedBox(height: 20.0),
                      //paragraph 2
                      _buildExpansionTile(
                        1,
                      //  Icons.fact_check,
                        Locales.string(context, "asthma-p2-title"),
                        'https://www.shutterstock.com/image-vector/set-symptoms-asthma-asthmatic-problems-260nw-1739911862.jpg',
                        Locales.string(context, "asthma-p2-detail"),
                      ),
                      const SizedBox(height: 20.0),
                      //paragraph 3
                      _buildExpansionTile(
                        2,
                      //  Icons.checklist,
                        Locales.string(context, "asthma-p3-title"),
                        'https://www.shutterstock.com/image-vector/asthma-triggers-medication-anti-inflammatory-600nw-1238174206.jpg',
                        Locales.string(context, "asthma-p3-detail"),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: _increaseExpansionFontSize,
      //       tooltip: 'Increase Font Size',
      //       child: Icon(Icons.zoom_in),
      //     ),
      //     SizedBox(height: 10), // Add some spacing between the buttons
      //     FloatingActionButton(
      //       onPressed: _decreaseExpansionFontSize,
      //       tooltip: 'Decrease Font Size',
      //       child: Icon(Icons.zoom_out),
      //     ),
      //   ],
      // ),
    );
  }

    Widget _buildExpansionTile(
        int index,
       // IconData icon,
        String title,
        String imageUrl,
        String detail
        ) {
      return ExpansionTile(
        // leading: Icon(
        //   icon,
        //   color: Colors.red,
        // ),
        title: Padding(
          padding: EdgeInsets.zero,
          child: Align(
            alignment: Alignment.centerLeft, // Align title to the left
            child: Text(
              title,
              style: TextStyle(
                fontSize: _expansionTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onExpansionChanged: (bool isExpanded) {
          setState(() {
            _isExpandedList[index] = isExpanded;
          });
        },
        initiallyExpanded: _isExpandedList[index],
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 300,
                    height: 300,
                    placeholder: (context, url) => Image.asset(
                      'assets/image_loading.png',
                      width: 100,
                      height: 100,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: _expansionSubtitleFontSize,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ], // Set the initial expansion state
      );
    }
}
