import 'package:domain/domain.dart';

class NewsArticle {
  final String source;
  final String logoUrl;
  final String date;
  final String title;
  final String category;
  final String imageUrl;
  final bool isVerified;

  NewsArticle({
    required this.source,
    required this.logoUrl,
    required this.date,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.isVerified,
  });

  factory NewsArticle.fromEntity(NewsArticleEntity entity) {
    return NewsArticle(
      source: entity.publisher,
      logoUrl: entity.publisherIcon,
      date: entity.date,
      title: entity.title,
      category: entity.category,
      imageUrl: entity.image,
      isVerified: entity.isVerified,
    );
  }
}