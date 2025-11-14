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
      username: json['username'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      verified: json['verified'] as bool? ?? false,
      logo: json['logo'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      stats: json['stats'] != null
          ? StatsModel.fromJson(json['stats'] as Map<String, dynamic>)
          : StatsModel(newsCount: '0', followers: '0', following: 0),
      isFollowing: json['is_following'] as bool? ?? false,
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

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) => StatsModel(
  newsCount: json['news_count'] as String? ?? '0',
  followers: json['followers'] as String? ?? '0',
  following: (json['following'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$StatsModelToJson(StatsModel instance) =>
    <String, dynamic>{
      'news_count': instance.newsCount,
      'followers': instance.followers,
      'following': instance.following,
    };

FiltersModel _$FiltersModelFromJson(Map<String, dynamic> json) => FiltersModel(
  sortBy: (json['sort_by'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList() ??
      ['Newest'],
  activeSort: json['active_sort'] as String? ?? 'Newest',
  viewMode: json['view_mode'] as String? ?? 'list',
);

Map<String, dynamic> _$FiltersModelToJson(FiltersModel instance) =>
    <String, dynamic>{
      'sort_by': instance.sortBy,
      'active_sort': instance.activeSort,
      'view_mode': instance.viewMode,
    };