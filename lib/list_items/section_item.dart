import 'list_item.dart';

class SectionItem extends ListItem {
  final String tag;
  final String title;
  final String rightButtonTitle;

  SectionItem({
    required this.tag,
    required this.title,
    required this.rightButtonTitle,
  });
}