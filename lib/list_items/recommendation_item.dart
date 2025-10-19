import 'list_item.dart';
import '../model/news_article.dart';

class RecommendationItem extends ListItem {
  final NewsArticle article;
  final bool showFollowButton;

  RecommendationItem({
    required this.article,
    this.showFollowButton = true,
  });
}