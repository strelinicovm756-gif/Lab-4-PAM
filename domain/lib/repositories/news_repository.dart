import '../entities/news_article_entity.dart';
import '../entities/publisher_details_entity.dart';

class FeedResult {
  final List<NewsArticleEntity> trendingNews;
  final List<NewsArticleEntity> recommendations;

  FeedResult({
    required this.trendingNews,
    required this.recommendations,
  });
}

abstract class NewsRepository {
  Future<FeedResult> getFeed();
  Future<PublisherDetailsEntity> getPublisherDetails();
}