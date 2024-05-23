import 'package:flutter/material.dart';
import 'package:ncd_myanmar/Page/video_player.dart';
import '../model/video_model.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                const Positioned(
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
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.face,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      video.source,
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  video.content,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
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