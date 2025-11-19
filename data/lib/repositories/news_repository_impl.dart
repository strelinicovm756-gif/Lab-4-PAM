import 'package:domain/domain.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<FeedResult> getFeed() async {
    try {
      print('Repository: Getting feed :');
      final feedResponse = await remoteDataSource.getFeed();

      final trendingNews = feedResponse.trendingNews
          .map((article) => article.toEntity())
          .toList();

      final recommendations = feedResponse.recommendations
          .map((article) => article.toEntity())
          .toList();

      print('Repository: Loaded ${trendingNews.length} trending + ${recommendations.length} recommendations');

      return FeedResult(
        trendingNews: trendingNews,
        recommendations: recommendations,
      );
    } catch (e) {
      print('Repository: Failed to load feed: $e');
      throw Exception('Failed to load feed: $e');
    }
  }

  @override
  Future<PublisherDetailsEntity> getPublisherDetails() async {
    try {
      print('Repository: Getting publisher details...');
      final details = await remoteDataSource.getPublisherDetails();
      print('Repository: Publisher details loaded');
      return details.toEntity();
    } catch (e) {
      print('Repository: Failed to load publisher details: $e');
      throw Exception('Failed to load publisher details: $e');
    }
  }
}