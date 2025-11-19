import 'package:json_annotation/json_annotation.dart';
import 'news_article_model.dart';

part 'feed_response_model.g.dart';

@JsonSerializable()
class FeedResponseModel {
  @JsonKey(name: 'trending_news')
  final List<NewsArticleModel> trendingNews;
  final List<NewsArticleModel> recommendations;

  FeedResponseModel({
    required this.trendingNews,
    required this.recommendations,
  });

  factory FeedResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedResponseModelToJson(this);
}