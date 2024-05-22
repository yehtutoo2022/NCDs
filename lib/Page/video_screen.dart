import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:http/http.dart' as http;
import '../model/video_model.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Future<List<Video>> _video;
  bool _isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Locales.string(context, "video"),
        ),
      ),
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
            return Center(
              child: Text('No video available'),
            );
          } else {
            List<Video>? videos = snapshot.data;
            return ListView.builder(
              itemCount: videos!.length,
              itemBuilder: (context, index) {
                return VideoCard(video: videos[index]);
              },
            );
          }
        },
      ),
    );
  }
}


class VideoCard extends StatefulWidget {
  final Video video;

  VideoCard({required this.video});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    implements YouTubePlayerListener {
  double _currentVideoSecond = 0.0;
  String _playerState = "";
  late FlutterYoutubeViewController _controller;

  @override
  void onCurrentSecond(double second) {
    print("onCurrentSecond second = $second");
    setState(() {
      _currentVideoSecond = second;
    });
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    _controller = controller;
    print("onYoutubeCreated");
  }

  void _loadOrCueVideo() {
    _controller.loadOrCueVideo(widget.video.videoUrl, _currentVideoSecond);
  }

  @override
  Widget build(BuildContext context) {
    String videoId = widget.video.videoUrl.split("v=")[1];
    // Extract video ID from URL
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          FlutterYoutubeView(
            onViewCreated: _onYoutubeCreated,
            listener: this,
            params: YoutubeParam(
              videoId: videoId,
              showUI: true,
              startSeconds: 0.0,
              showYoutube: false,
              showFullScreen: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Current state: $_playerState',
                  style: TextStyle(color: Colors.blue),
                ),
                ElevatedButton(
                  onPressed: _loadOrCueVideo,
                  child: Text('Click reload video'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

