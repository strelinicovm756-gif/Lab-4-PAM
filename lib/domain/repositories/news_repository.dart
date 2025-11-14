import '../entities/news_article_entity.dart';
import '../entities/user_entity.dart';
import '../entities/publisher_details_entity.dart';

abstract class NewsRepository {
  Future<Map<String, dynamic>> getFeed();
  Future<UserEntity> getUser();
  Future<List<NewsArticleEntity>> getTrendingNews();
  Future<List<NewsArticleEntity>> getRecommendations();
  Future<PublisherDetailsEntity> getPublisherDetails();
}