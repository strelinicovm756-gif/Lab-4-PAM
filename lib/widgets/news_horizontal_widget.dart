import 'package:flutter/material.dart';
import '../list_items/news_horizontal_list_item.dart';
import 'news_card_widget.dart';

class NewsHorizontalWidget extends StatelessWidget {
  final NewsHorizontalListItem item;

  const NewsHorizontalWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      margin: EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: item.newsCards.length,
        itemBuilder: (context, index) {
          return NewsCardWidget(item: item.newsCards[index]);
        },
      ),
    );
  }
}
