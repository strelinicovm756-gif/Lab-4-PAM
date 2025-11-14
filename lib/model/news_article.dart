import '../domain/entities/news_article_entity.dart';

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

  // NOU: Creare din Entity
  factory NewsArticle.fromEntity(NewsArticleEntity entity) {
    return NewsArticle(
      id: entity.id,
      title: entity.title,
      source: entity.publisher,
      date: entity.date,
      imageUrl: entity.image,
      logoUrl: entity.publisherIcon,
      category: entity.category,
      isVerified: entity.isVerified,
      isLocalImage: false,
    );
  }

  // Păstrăm pentru backwards compatibility
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
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