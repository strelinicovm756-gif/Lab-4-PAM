import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feed_response_model.dart';
import '../models/publisher_details_model.dart';

class NewsRemoteDataSource {
  final String baseUrl = 'https://test-api-jlbn.onrender.com';

  Future<FeedResponseModel> getFeed() async {
    try {
      print('Fetching feed from: $baseUrl/v4/feed');

      final response = await http.get(
        Uri.parse('$baseUrl/v4/feed'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Feed data received successfully');
        return FeedResponseModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load feed: ${response.statusCode}');
      }
    } catch (e) {
      print('Remote feed error: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<PublisherDetailsModel> getPublisherDetails() async {
    try {
      print('Fetching publisher details from: $baseUrl/v4/feed/details');

      final response = await http.get(
        Uri.parse('$baseUrl/v4/feed/details'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Publisher details received successfully');
        return PublisherDetailsModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load publisher details: ${response.statusCode}');
      }
    } catch (e) {
      print('Remote publisher details error: $e');
      throw Exception('Network error: $e');
    }
  }
}