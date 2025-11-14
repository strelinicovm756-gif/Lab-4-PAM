import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feed_response_model.dart';
import '../models/publisher_details_model.dart';

class NewsRemoteDataSource {
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/v4';
  final http.Client client;

  NewsRemoteDataSource({http.Client? client}) : client = client ?? http.Client();

  Future<FeedResponseModel> getFeed() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/feed'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Connection timeout');
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return FeedResponseModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load feed. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<PublisherDetailsModel> getPublisherDetails() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/feed/details'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Connection timeout');
        },
      );

      if (response.statusCode == 200) {
        print('API Response:');
        print(response.body);

        final jsonData = json.decode(response.body);

        print('Parsed JSON:');
        print(jsonData);

        return PublisherDetailsModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load details. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error details: $e');
      throw Exception('Network error: $e');
    }
  }
}
