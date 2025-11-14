import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/feed_response_model.dart';

class NewsLocalDataSource {
  Future<FeedResponseModel> getLocalFeed() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/news_data.json');
      final jsonData = json.decode(jsonString);
      return FeedResponseModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load local data: $e');
    }
  }
}