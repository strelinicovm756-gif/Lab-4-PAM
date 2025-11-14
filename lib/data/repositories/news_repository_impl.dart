import '../../domain/entities/news_article_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/publisher_details_entity.dart';
import '../../domain/entities/publisher_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';
import '../datasources/news_local_datasource.dart';
import '../models/feed_response_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  FeedResponseModel? _cachedFeed;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Map<String, dynamic>> getFeed() async {
    try {
      print('Trying API...');
      _cachedFeed = await remoteDataSource.getFeed();
      print('API Success ');

      return {
        'user': _cachedFeed!.user,
        'trending_news': _cachedFeed!.trendingNews,
        'recommendations': _cachedFeed!.recommendations,
      };
    } catch (e) {
      print('API failed: $e');
      print('Loading local JSON:');

      try {
        _cachedFeed = await localDataSource.getLocalFeed();
        print('Local JSON Success');

        return {
          'user': _cachedFeed!.user,
          'trending_news': _cachedFeed!.trendingNews,
          'recommendations': _cachedFeed!.recommendations,
        };
      } catch (localError) {
        throw Exception('Both API and local failed: $localError');
      }
    }
  }

  @override
  Future<UserEntity> getUser() async {
    if (_cachedFeed == null) await getFeed();

    return UserEntity(
      name: _cachedFeed!.user.name,
      avatarUrl: _cachedFeed!.user.profileImage,
    );
  }

  @override
  Future<List<NewsArticleEntity>> getTrendingNews() async {
    if (_cachedFeed == null) await getFeed();

    return _cachedFeed!.trendingNews
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<NewsArticleEntity>> getRecommendations() async {
    if (_cachedFeed == null) await getFeed();

    return _cachedFeed!.recommendations
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<PublisherDetailsEntity> getPublisherDetails() async {
    try {
      print('Trying API for publisher details:');
      final details = await remoteDataSource.getPublisherDetails();
      print('Publisher details API success');
      return details.toEntity();
    } catch (e) {
      print('Publisher details API failed: $e');
      print('Using hardcoded fallback data');

      return PublisherDetailsEntity(
        publisher: PublisherEntity(
          username: 'forbesnews',
          name: 'Forbes',
          verified: true,
          logo: 'https://cdn.worldvectorlogo.com/logos/forbes-2.svg',
          bio: 'Empowering your business journey with expert insights and influential perspectives.',
          stats: PublisherStatsEntity(
            newsCount: '6.8k',
            followers: '2.5k',
            following: 100,
          ),
          isFollowing: false,
        ),
        sortOptions: ['Newest', 'Oldest', 'Most Popular'],
        activeSortOption: 'Newest',
        articles: [
          NewsArticleEntity(
            id: 301,
            title: 'Tech Startup Secures \$50 Million Funding for Expansion',
            publisher: 'Forbes',
            date: 'Jun 11, 2023',
            image: 'https://t4.ftcdn.net/jpg/03/00/14/39/360_F_300143961_8kJTPiTbWallCIBxO0GQzoxgwE9cIRGG.jpg',
            publisherIcon: 'https://cdn.worldvectorlogo.com/logos/forbes-2.svg',
            category: 'Business',
            isVerified: true,
          ),
          NewsArticleEntity(
            id: 302,
            title: 'Global CEOs Predict Market Growth in 2024',
            publisher: 'Forbes',
            date: 'Jun 10, 2023',
            image: 'https://cdn.pixabay.com/photo/2018/02/08/10/22/desk-3139127_1280.jpg',
            publisherIcon: 'https://cdn.worldvectorlogo.com/logos/forbes-2.svg',
            category: 'Finance',
            isVerified: true,
          ),
        ],
      );
    }
  }
}