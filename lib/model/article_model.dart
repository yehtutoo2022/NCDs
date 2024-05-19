//model is important to maintain favorite status to provider and prevent duplicate
class Article {
  final String category;
  final String source;
  final String title;
  final String contentP1;
  final String contentP1Sub;
  final String contentP2;
  final String contentP2Sub;
  final String contentP3;
  final String contentP3Sub;
  final String contentP4;
  final String contentP4Sub;
  final String contentP5;
  final String contentP5Sub;
  final String imageUrl;

  Article({
    required this.category,
    required this.source,
    required this.title,
    required this.contentP1,
    required this.contentP1Sub,
    required this.contentP2,
    required this.contentP2Sub,
    required this.contentP3,
    required this.contentP3Sub,
    required this.contentP4,
    required this.contentP4Sub,
    required this.contentP5,
    required this.contentP5Sub,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      category: json['Category'] ?? '',
      source: json['Source'] ?? '',
      title: json['Title'] ?? '',
      contentP1: json['Content_P1'] ?? '',
      contentP1Sub: json['Content_P1_Sub'] ?? '',
      contentP2: json['Content_P2'] ?? '',
      contentP2Sub: json['Content_P2_Sub'] ?? '',
      contentP3: json['Content_P3'] ?? '',
      contentP3Sub: json['Content_P3_Sub'] ?? '',
      contentP4: json['Content_P4'] ?? '',
      contentP4Sub: json['Content_P4_Sub'] ?? '',
      contentP5: json['Content_P5'] ?? '',
      contentP5Sub: json['Content_P5_Sub'] ?? '',
      imageUrl: json['ImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Category': category,
      'Source': source,
      'Title': title,
      'Content_P1': contentP1,
      'Content_P1_Sub': contentP1Sub,
      'Content_P2': contentP2,
      'Content_P2_Sub': contentP2Sub,
      'Content_P3': contentP3,
      'Content_P3_Sub': contentP3Sub,
      'Content_P4': contentP4,
      'Content_P4_Sub': contentP4Sub,
      'Content_P5': contentP5,
      'Content_P5_Sub': contentP5Sub,
      'ImageUrl': imageUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Article &&
        other.category == category &&
        other.source == source &&
        other.title == title &&
        other.contentP1 == contentP1 &&
        other.contentP2 == contentP2 &&
        other.contentP2Sub == contentP2Sub &&
        other.contentP3 == contentP3 &&
        other.contentP3Sub == contentP3Sub &&
        other.contentP4 == contentP4 &&
        other.contentP4Sub == contentP4Sub &&
        other.contentP5 == contentP5 &&
        other.contentP5Sub == contentP5Sub &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
        category,
        source,
        title,
        contentP1,
        contentP1Sub,
        contentP2,
        contentP2Sub,
        contentP3,
        contentP3Sub,
        contentP4,
        contentP4Sub,
        contentP5,
        contentP5Sub,
        imageUrl);
  }
}
