import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    super.initState();
    _video = _fetchVideo();
  }

  Future<List<Video>> _fetchVideo() async {
    try {
      String githubRawUrl = 'https://raw.githubusercontent.com/yehtutoo2022/NCDs/master/assets/video_data.json';
      final response = await http.get(Uri.parse(githubRawUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Video> videoList = jsonList.map((e) => Video.fromJson(e)).toList();

        setState(() {
          _isLoading = false;
          _allVideos = videoList;
          _filteredVideos = videoList;
          _categories.addAll(
            videoList.map((video) => video.category).toSet().toList(),
          );
        });
        return videoList;
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
                      style: TextStyle(fontSize: 14)
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
      _video = _fetchVideo();
    });
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
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      backgroundColor: Colors.brown[100],
      body: FutureBuilder<List<Video>>(
        future: _video,
        builder: (context, snapshot) {
          if (_isLoading) {
            return Center(
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
                itemCount: _filteredVideos.length,
                itemBuilder: (context, index) {
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

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YoutubePlayerScreen(videoId: video.videoId),
                ),
              );
            },
            child: Stack(
              children: [
                Image.network(
                  video.imageThumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 64.0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: Text(
              video.title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
              ),
            ),
            subtitle: Text(
              video.content,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YoutubePlayerScreen(videoId: video.videoId),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;

  const YoutubePlayerScreen({super.key, required this.videoId});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  final _controller = YoutubePlayerController();

  @override
  void initState() {
    super.initState();
    _controller.loadVideoById(videoId: widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
        ),
      ),
    );
  }
}







