import 'package:json_annotation/json_annotation.dart';
import 'news_article_model.dart';
import '../../domain/entities/publisher_details_entity.dart';
import '../../domain/entities/publisher_entity.dart';

part 'publisher_details_model.g.dart';

@JsonSerializable()
class PublisherDetailsModel {
  final PublisherModel publisher;
  final FiltersModel filters;
  final List<NewsArticleModel> news;

  PublisherDetailsModel({
    required this.publisher,
    required this.filters,
    required this.news,
  });

  factory PublisherDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PublisherDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherDetailsModelToJson(this);

  PublisherDetailsEntity toEntity() {
    return PublisherDetailsEntity(
      publisher: publisher.toEntity(),
      sortOptions: filters.sortBy,
      activeSortOption: filters.activeSort,
      articles: news.map((model) => model.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class PublisherModel {
  final String username;
  final String name;
  final bool verified;
  final String logo;
  final String bio;
  final StatsModel stats;
  @JsonKey(name: 'is_following')
  final bool isFollowing;

  PublisherModel({
    required this.username,
    required this.name,
    required this.verified,
    required this.logo,
    required this.bio,
    required this.stats,
    required this.isFollowing,
  });

  factory PublisherModel.fromJson(Map<String, dynamic> json) =>
      _$PublisherModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherModelToJson(this);

  PublisherEntity toEntity() {
    return PublisherEntity(
      username: username,
      name: name,
      verified: verified,
      logo: logo,
      bio: bio,
      stats: stats.toEntity(),
      isFollowing: isFollowing,
    );
  }
}

@JsonSerializable()
class StatsModel {
  @JsonKey(name: 'news_count')
  final String newsCount;
  final String followers;
  final int following;

  StatsModel({
    required this.newsCount,
    required this.followers,
    required this.following,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatsModelToJson(this);

  PublisherStatsEntity toEntity() {
    return PublisherStatsEntity(
      newsCount: newsCount,
      followers: followers,
      following: following,
    );
  }
}

@JsonSerializable()
class FiltersModel {
  @JsonKey(name: 'sort_by')
  final List<String> sortBy;
  @JsonKey(name: 'active_sort')
  final String activeSort;
  @JsonKey(name: 'view_mode')
  final String viewMode;

  FiltersModel({
    required this.sortBy,
    required this.activeSort,
    required this.viewMode,
  });

  factory FiltersModel.fromJson(Map<String, dynamic> json) =>
      _$FiltersModelFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersModelToJson(this);
}