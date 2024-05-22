import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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

class _VideoCardState extends State<VideoCard> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          widget.video.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.video.category,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        leading: SizedBox(
          width: 100,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => VideoDetailScreen(video: widget.video),
        //     ),
        //   );
        // },
      ),
    );
  }
}
