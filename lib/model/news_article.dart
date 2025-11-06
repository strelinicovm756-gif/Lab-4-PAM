class NewsArticle {
  final int? id;
  final String title;
  final String source;
  final String date;
  final String imageUrl;
  final String category;
  final bool isVerified;
  final bool isLocalImage;
  final String logoUrl;

  NewsArticle({
    this.id,
    required this.title,
    required this.source,
    required this.date,
    required this.imageUrl,
    required this.category,
    this.isVerified = false,
    this.isLocalImage = false,
    required this.logoUrl,
  });

  // Factory constructor pentru trending_news
  factory NewsArticle.fromTrendingNews(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'] ?? '',
      source: json['publisher'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['image'] ?? '',
      logoUrl: json['publisher_icon'] ?? '',
      category: json['category'] ?? '',
      isVerified: json['is_verified'] ?? false,
      isLocalImage: false,
    );
  }

  // Factory constructor pentru recommendations
  factory NewsArticle.fromRecommendation(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'] ?? '',
      source: json['publisher'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['image'] ?? '',
      logoUrl: json['publisher_icon'] ?? '',
      category: json['category'] ?? '',
      isVerified: json['publisher_verified'] ?? false,
      isLocalImage: false,
    );
  }

  // Generic fromJson (backward compatible)
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('publisher')) {
      if (json.containsKey('publisher_verified')) {
        return NewsArticle.fromRecommendation(json);
      } else {
        return NewsArticle.fromTrendingNews(json);
      }
    }

    return NewsArticle(
      id: json['id'],
      title: json['title'] ?? '',
      source: json['source'] ?? json['publisher'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['imageUrl'] ?? json['image'] ?? '',
      category: json['category'] ?? '',
      isVerified: json['isVerified'] ?? json['is_verified'] ?? json['publisher_verified'] ?? false,
      isLocalImage: json['isLocalImage'] ?? false,
      logoUrl: json['logoUrl'] ?? json['publisher_icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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