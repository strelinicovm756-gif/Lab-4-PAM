import 'package:flutter/material.dart';
import '../list_items/nav_bar_list_item.dart';
import '../resources/strings.dart';

class TopNavBarWidget extends StatelessWidget {
  final NavBarListItem item;

  const TopNavBarWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu, size: 28, color: Colors.black87),
              Icon(Icons.notifications_outlined, size: 28, color: Colors.black87),
            ],
          ),
          SizedBox(height: 24),
          Text(
            '${Strings.welcomeBack}, ${item.userName}!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Text(
            Strings.discoverNews,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
