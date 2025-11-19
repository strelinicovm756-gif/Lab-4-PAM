
part of 'feed_response_model.dart';

// JsonSerializableGenerator

FeedResponseModel _$FeedResponseModelFromJson(Map<String, dynamic> json) =>
    FeedResponseModel(
      trendingNews: (json['trending_news'] as List<dynamic>)
          .map((e) => NewsArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => NewsArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedResponseModelToJson(FeedResponseModel instance) =>
    <String, dynamic>{
      'articles': instance.trendingNews,
      'recommendations': instance.recommendations,
    };
