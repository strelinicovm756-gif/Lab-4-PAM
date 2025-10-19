import 'list_item.dart';
import 'news_card_item.dart';

class NewsHorizontalListItem extends ListItem {
  final List<NewsCardItem> newsCards;

  NewsHorizontalListItem({required this.newsCards});
}