class NewsArticle {
  final String title;
  final String source;
  final String date;
  final String imageUrl;
  final String category;
  final bool isVerified;
  final bool isLocalImage;
  final String logoUrl;

  NewsArticle({
    required this.title,
    required this.source,
    required this.date,
    required this.imageUrl,
    required this.category,
    this.isVerified = false,
    this.isLocalImage = true,
    required this.logoUrl,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      source: json['source'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      isVerified: json['isVerified'] ?? false,
      isLocalImage: json['isLocalImage'] ?? true,
      logoUrl: json['logoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'source': source,
      'date': date,
      'imageUrl': imageUrl,
      'category': category,
      'isVerified': isVerified,
      'isLocalImage': isLocalImage,
      'logoUrl': logoUrl,
    };
  }
}