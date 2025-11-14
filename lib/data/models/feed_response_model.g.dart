// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedResponseModel _$FeedResponseModelFromJson(Map<String, dynamic> json) =>
    FeedResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      trendingNews: (json['trending_news'] as List<dynamic>)
          .map((e) => NewsArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => NewsArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedResponseModelToJson(FeedResponseModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'trending_news': instance.trendingNews,
      'recommendations': instance.recommendations,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  name: json['name'] as String,
  profileImage: json['profile_image'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'profile_image': instance.profileImage,
};
