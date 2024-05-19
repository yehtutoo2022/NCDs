import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../../model/favorite_model.dart';

class HeartDiseaseScreen extends StatefulWidget {
  const HeartDiseaseScreen({super.key,});

  @override
  State<HeartDiseaseScreen> createState() => _HeartDiseaseScreenState();
}

class _HeartDiseaseScreenState extends State<HeartDiseaseScreen> {
  bool isBookmarked = false;
  final List<bool> _isExpandedList = [false, false, false, false, false, false];
  double _expansionTitleFontSize = 16.0;
  double _expansionSubtitleFontSize = 14.0;
  double minFontSize = 12.0;
  double maxFontSize = 24.0;

  @override
  void initState() {
    super.initState();
    // Check if 'Hypertension' is in the favorites list
    isBookmarked = Provider.of<FavoriteDataModel>(context, listen: false)
        .favorites
        .contains('Heart-Disease');
  }
  void _toggleFavorite() {
    setState(() {
      isBookmarked = !isBookmarked;
      if (isBookmarked) {
        // Add item to favorites list
        Provider.of<FavoriteDataModel>(context, listen: false).addFavorite('Heart-Disease');
      } else {
        // Remove item from favorites list
        Provider.of<FavoriteDataModel>(context, listen: false).removeFavorite('Heart-Disease');
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            backgroundColor: Colors.brown[100],
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(Locales.string(context, "heart-disease")),
              background: Image.asset('assets/images/heart-disease.jpg', fit: BoxFit.cover),
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
                          Locales.string(context, "heart-disease-detail"),
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
                        Locales.string(context, "heart-disease-p1-title"),
                        'https://www.shutterstock.com/shutterstock/photos/2050010759/display_1500/stock-vector-heart-disease-risk-factors-infographic-in-flat-design-vector-illustration-2050010759.jpg',
                        Locales.string(context, "heart-disease-p1-detail"),
                      ),
                      const SizedBox(height: 20.0),
                      //paragraph 2
                      _buildExpansionTile(
                        1,
                        //  Icons.fact_check,
                        Locales.string(context, "heart-disease-p2-title"),
                        'https://www.shutterstock.com/shutterstock/photos/1861246237/display_1500/stock-vector-heart-attack-warning-signs-colored-vector-icons-set-medical-line-style-background-medicine-and-1861246237.jpg',
                        Locales.string(context, "heart-disease-p2-detail"),
                      ),
                      const SizedBox(height: 20.0),
                      //paragraph 3
                      _buildExpansionTile(
                        2,
                        //  Icons.checklist,
                        Locales.string(context, "heart-disease-p3-title"),
                        'https://www.shutterstock.com/image-photo/cardiologist-use-stethoscope-act-listening-600nw-1844879092.jpg',
                        Locales.string(context, "heart-disease-p3-detail"),
                      ),
                      const SizedBox(height: 20.0),
                      //p4
                      _buildExpansionTile(
                        3,
                        //  Icons.checklist,
                        Locales.string(context, "heart-disease-p4-title"),
                        'https://www.shutterstock.com/image-photo/young-woman-suffering-heart-attack-260nw-1515654905.jpg',
                        Locales.string(context, "heart-disease-p4-detail"),
                      ),
                      const SizedBox(height: 20.0),
                      //p5
                      _buildExpansionTile(
                        4,
                        //  Icons.checklist,
                        Locales.string(context, "heart-disease-p5-title"),
                        'https://www.shutterstock.com/image-illustration/heart-failure-congestive-260nw-375879697.jpg',
                        Locales.string(context, "heart-disease-p5-detail"),
                      ),
                      const SizedBox(height: 20.0),
                      //p6
                      _buildExpansionTile(
                        5,
                        //  Icons.checklist,
                        Locales.string(context, "heart-disease-p6-title"),
                        'https://www.shutterstock.com/shutterstock/photos/188828342/display_1500/stock-photo-heart-disease-prevention-word-circle-concept-with-great-terms-such-as-exercise-eat-heatlhy-and-188828342.jpg',
                        Locales.string(context, "heart-disease-p6-detail"),
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
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ], // Set the initial expansion state
    );
  }

}
