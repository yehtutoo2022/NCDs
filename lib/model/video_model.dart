// class Video {
//   final String category;
//   final String source;
//   final String title;
//   final String content;
//   final String videoUrl;
//
//   Video({
//     required this.category,
//     required this.source,
//     required this.title,
//     required this.content,
//     required this.videoUrl,
//   });
//
//   factory Video.fromJson(Map<String, dynamic> json) {
//     return Video(
//       category: json['Category'] as String,
//       source: json['Source'] as String,
//       title: json['Title'] as String,
//       content: json['Content'] as String,
//       videoUrl: json['Video Url'] as String,
//     );
//   }
// }
class Video {
  final String category;
  final String source;
  final String title;
  final String content;
  final String videoUrl;
  final String videoId;
  final String imageThumbnail;

  Video({
    required this.category,
    required this.source,
    required this.title,
    required this.content,
    required this.videoUrl,
    required this.videoId,
    required this.imageThumbnail,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      category: json['Category'],
      source: json['Source'],
      title: json['Title'],
      content: json['Content'],
      videoUrl: json['Video Url'],
      videoId: _extractVideoId(json['Video Url']),
      imageThumbnail: json['Image Thumbnail'],
    );
  }

  static String _extractVideoId(String url) {
    final uri = Uri.parse(url);
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'] ?? '';
    } else if (uri.host == 'youtu.be') {
      return uri.pathSegments.first;
    }
    return '';
  }
}
