import 'dart:convert';
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
              //  return YoutubePlayerScreen(videoId: 'KVbOHGwy4gY');
              },
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
    return ListTile(
      title: Text(video.title),
      onTap: () {
        // Navigate to the video player screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YoutubePlayerScreen(videoId: video.videoId),
          ),
        );
      },
    );
  }
}
// class YoutubePlayerScreen extends StatelessWidget {
//   final String videoId;
//
//   const YoutubePlayerScreen({Key? key, required this.videoId}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: Center(
//         child: Text('Youtube Player for videoId: $videoId'), // Integrate Youtube Player here
//       ),
//     );
//   }
// }

class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;

  const YoutubePlayerScreen({super.key, required this.videoId});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  final _controller = YoutubePlayerController();
 // String videoId = "KVbOHGwy4gY";

  @override
  void initState() {
    super.initState();
    // TO load a video by its unique id
   // _controller.loadVideoById(videoId: "KVbOHGwy4gY");
    _controller.loadVideoById(videoId: widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Center(
          // Youtube player as widget
          child: YoutubePlayer(
            controller: _controller, // Controler that we created earlier
            aspectRatio: 16 / 9,	 // Aspect ratio you want to take in screen
          ),
        ),
      ),
    );
  }
}







