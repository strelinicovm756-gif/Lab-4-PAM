import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/news_article.dart';

class NewsService {

  Future<Map<String, dynamic>> loadNewsData() async {
    try {

      final String jsonString = await rootBundle.loadString('assets/data/news_data.json');


      await Future.delayed(Duration(seconds: 2));


      final Map<String, dynamic> jsonData = json.decode(jsonString);

      return jsonData;
    } catch (e) {
      print('Error loading news data: $e');
      rethrow;
    }
  }


  List<NewsArticle> parseArticles(List<dynamic> articlesJson) {
    return articlesJson
        .map((articleJson) => NewsArticle.fromJson(articleJson))
        .toList();
  }

  Map<String, dynamic> parseSection(Map<String, dynamic> sectionJson) {
    return {
      'tag': sectionJson['tag'] ?? '',
      'title': sectionJson['title'] ?? '',
      'rightButtonTitle': sectionJson['rightButtonTitle'] ?? '',
    };
  }
}