import 'package:json_annotation/json_annotation.dart';
import 'news_article_model.dart';

part 'feed_response_model.g.dart';

@JsonSerializable()
class FeedResponseModel {
  final UserModel user;
  @JsonKey(name: 'trending_news')
  final List<NewsArticleModel> trendingNews;
  final List<NewsArticleModel> recommendations;

  FeedResponseModel({
    required this.user,
    required this.trendingNews,
    required this.recommendations,
  });

  factory FeedResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedResponseModelToJson(this);
}

@JsonSerializable()
class UserModel {
  final String name;
  @JsonKey(name: 'profile_image')
  final String? profileImage;

  UserModel({
    required this.name,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}