class Video {
  final String category;
  final String source;
  final String title;
  final String content;
  final String videoUrl;

  Video({
    required this.category,
    required this.source,
    required this.title,
    required this.content,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      category: json['category'],
      source: json['source'],
      title: json['title'],
      content: json['content'],
      videoUrl: json['videoUrl'],
    );
  }
}
