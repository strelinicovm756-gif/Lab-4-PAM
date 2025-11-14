import 'news_article_entity.dart';
import 'publisher_entity.dart';

class PublisherDetailsEntity {
  final PublisherEntity publisher;
  final List<String> sortOptions;
  final String activeSortOption;
  final List<NewsArticleEntity> articles;

  PublisherDetailsEntity({
    required this.publisher,
    required this.sortOptions,
    required this.activeSortOption,
    required this.articles,
  });
}