// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublisherDetailsModel _$PublisherDetailsModelFromJson(
        Map<String, dynamic> json) =>
    PublisherDetailsModel(
      publisher:
          PublisherModel.fromJson(json['publisher'] as Map<String, dynamic>),
      filters: FiltersModel.fromJson(json['filters'] as Map<String, dynamic>),
      news: (json['news'] as List<dynamic>)
          .map((e) => NewsArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PublisherDetailsModelToJson(
        PublisherDetailsModel instance) =>
    <String, dynamic>{
      'publisher': instance.publisher,
      'filters': instance.filters,
      'news': instance.news,
    };

PublisherModel _$PublisherModelFromJson(Map<String, dynamic> json) =>
    PublisherModel(
      username: json['username'] as String,
      name: json['name'] as String,
      verified: json['verified'] as bool,
      logo: json['logo'] as String,
      bio: json['bio'] as String,
      stats:
          PublisherStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      isFollowing: json['is_following'] as bool,
    );

Map<String, dynamic> _$PublisherModelToJson(PublisherModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'verified': instance.verified,
      'logo': instance.logo,
      'bio': instance.bio,
      'stats': instance.stats,
      'is_following': instance.isFollowing,
    };

PublisherStatsModel _$PublisherStatsModelFromJson(Map<String, dynamic> json) =>
    PublisherStatsModel(
      newsCount: json['news_count'] as String,
      followers: json['followers'] as String,
      following: (json['following'] as num).toInt(),
    );

Map<String, dynamic> _$PublisherStatsModelToJson(
        PublisherStatsModel instance) =>
    <String, dynamic>{
      'news_count': instance.newsCount,
      'followers': instance.followers,
      'following': instance.following,
    };

FiltersModel _$FiltersModelFromJson(Map<String, dynamic> json) => FiltersModel(
      sortBy:
          (json['sort_by'] as List<dynamic>).map((e) => e as String).toList(),
      activeSort: json['active_sort'] as String,
      viewMode: json['view_mode'] as String,
    );

Map<String, dynamic> _$FiltersModelToJson(FiltersModel instance) =>
    <String, dynamic>{
      'sort_by': instance.sortBy,
      'active_sort': instance.activeSort,
      'view_mode': instance.viewMode,
    };
