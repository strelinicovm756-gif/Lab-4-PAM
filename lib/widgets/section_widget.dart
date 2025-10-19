import 'package:flutter/material.dart';
import '../list_items/section_item.dart';

class SectionWidget extends StatelessWidget {
  final SectionItem item;
  final Function(String) onTap;

  const SectionWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          if (item.rightButtonTitle.isNotEmpty)
            GestureDetector(
              onTap: () => onTap(item.tag),
              child: Text(
                item.rightButtonTitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF999999),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}