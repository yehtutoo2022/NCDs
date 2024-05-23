import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
import 'package:ncd_myanmar/Page/video_card.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../model/video_model.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Future<List<Video>> _video;
  bool _isLoading = true;
  List<Video> _allVideos = [];
  List<Video> _filteredVideos = [];
  String _selectedCategory = 'All';
  List<String> _categories = ['All'];
//added
  bool _isFetchingMore = false;
  int _currentPage = 0;
  final int _videosPerPage = 10;
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
   // _video = _fetchVideo();
    _video = _fetchVideo(_currentPage);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Future<List<Video>> _fetchVideo() async {
  //   try {
  //     String githubRawUrl = 'https://raw.githubusercontent.com/yehtutoo2022/NCDs/master/assets/video_data.json';
  //     final response = await http.get(Uri.parse(githubRawUrl));
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonList = jsonDecode(response.body);
  //       List<Video> videoList = jsonList.map((e) => Video.fromJson(e)).toList();
  //
  //       setState(() {
  //         _isLoading = false;
  //         _allVideos = videoList;
  //         _filteredVideos = videoList;
  //         _categories.addAll(
  //           videoList.map((video) => video.category).toSet().toList(),
  //         );
  //       });
  //       return videoList;
  //     } else {
  //       throw Exception('Failed to load video');
  //     }
  //   } catch (e) {
  //     print('Error loading video: $e');
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return [];
  //   }
  // }

  Future<List<Video>> _fetchVideo(int page) async {
    try {
      String githubRawUrl = 'https://raw.githubusercontent.com/yehtutoo2022/NCDs/master/assets/video_data.json';
      final response = await http.get(Uri.parse(githubRawUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Video> videoList = jsonList.map((e) => Video.fromJson(e)).toList();

        int start = page * _videosPerPage;
        int end = start + _videosPerPage;
        List<Video> paginatedVideos = videoList.sublist(start, end > videoList.length ? videoList.length : end);

        setState(() {
          _isLoading = false;
          if (page == 0) {
            _allVideos = paginatedVideos;
            _categories.addAll(
              videoList.map((video) => video.category).toSet().toList(),
            );
            _categories.sort(); //sort alphabetically
          } else {
            _allVideos.addAll(paginatedVideos);
          }
          _filterVideos();
        });

        return paginatedVideos;
      } else {
        throw Exception('Failed to load video');
      }
    } catch (e) {
      print('Error loading video: $e');
      setState(() {
        _isLoading = false;
      });
      return [];
    }
  }


  void _filterVideos() {
    if (_selectedCategory == 'All') {
      _filteredVideos = _allVideos;
    } else {
      _filteredVideos = _allVideos.where((video) => video.category == _selectedCategory).toList();
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
                      _filterVideos();
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

  Future<void> _refreshVideos() async {
    setState(() {
      _currentPage = 0;
      _video = _fetchVideo(_currentPage);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
        _currentPage++;
      });
      _fetchVideo(_currentPage).then((_) {
        setState(() {
          _isFetchingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Locales.string(context, "videos"),
        ),
        backgroundColor: Colors.brown[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      backgroundColor: Colors.brown[100],
      body: FutureBuilder<List<Video>>(
        future: _video,
        builder: (context, snapshot) {
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No video available'),
            );
          } else {
            List<Video>? videos = snapshot.data;
            return RefreshIndicator(
              onRefresh: _refreshVideos,
              child: ListView.builder(
                //added
                controller: _scrollController,
                itemCount: _filteredVideos.length + (_isFetchingMore ? 1 : 0),
               // itemCount: _filteredVideos.length,
               //  itemBuilder: (context, index) {
               //    return VideoCard(video: _filteredVideos[index]);
               //  },
                itemBuilder: (context, index) {
                  if (index == _filteredVideos.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return VideoCard(video: _filteredVideos[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}








