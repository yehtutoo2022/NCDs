import 'dart:convert';

class Video {
  String category;
  String source;
  String title;
  String content;
  String videoUrl;

  Video({
    required this.category,
    required this.source,
    required this.title,
    required this.content,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      category: json['Category'] as String,
      source: json['Source'] as String,
      title: json['Title'] as String,
      content: json['Content'] as String,
      videoUrl: json['Video Url'] as String,
    );
  }

  String toJsonString() {
    Map<String, dynamic> jsonMap = {
      "Category": category,
      "Source": source,
      "Title": title,
      "Content": content,
      "Video Url": videoUrl
    };
    return jsonEncode(jsonMap);
  }
}
