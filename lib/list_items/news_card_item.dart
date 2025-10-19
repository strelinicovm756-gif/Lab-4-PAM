import 'list_item.dart';
import '../model/news_article.dart';

class NewsCardItem extends ListItem {
  final NewsArticle article;

  NewsCardItem({required this.article});
}