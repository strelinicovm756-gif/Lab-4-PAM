import '../entities/news_article_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/news_repository.dart';

class GetFeedUseCase {
  final NewsRepository repository;

  GetFeedUseCase(this.repository);

  Future<FeedData> execute() async {
    try {
      await repository.getFeed();

      return FeedData(
        user: await repository.getUser(),
        trendingNews: await repository.getTrendingNews(),
        recommendations: await repository.getRecommendations(),
      );
    } catch (e) {
      throw Exception('Failed to load feed: $e');
    }
  }
}

class FeedData {
  final UserEntity user;
  final List<NewsArticleEntity> trendingNews;
  final List<NewsArticleEntity> recommendations;

  FeedData({
    required this.user,
    required this.trendingNews,
    required this.recommendations,
  });
}