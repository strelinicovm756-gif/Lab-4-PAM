import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/news_article.dart';

class NewsService {
  // Încărcare asincronă din JSON
  Future<Map<String, dynamic>> loadNewsData() async {
    try {
      // Încarcă fișierul JSON
      final String jsonString = await rootBundle.loadString('assets/data/news_data.json');

      // Simuleaza delay (ca un API)
      await Future.delayed(Duration(seconds: 1));

      // Parse JSON
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      return jsonData;
    } catch (e) {
      print('Error loading news data: $e');
      rethrow;
    }
  }

  // Parse user name
  String parseUserName(Map<String, dynamic>? userData) {
    if (userData == null) return 'User';
    return userData['name'] ?? 'User';
  }

  // Parse trending news
  List<NewsArticle> parseTrendingNews(List<dynamic>? trendingJson) {
    if (trendingJson == null || trendingJson.isEmpty) return [];

    return trendingJson
        .map((json) => NewsArticle.fromTrendingNews(json))
        .toList();
  }

  // Parse recommendations
  List<NewsArticle> parseRecommendations(List<dynamic>? recommendationsJson) {
    if (recommendationsJson == null || recommendationsJson.isEmpty) return [];

    return recommendationsJson
        .map((json) => NewsArticle.fromRecommendation(json))
        .toList();
  }
}