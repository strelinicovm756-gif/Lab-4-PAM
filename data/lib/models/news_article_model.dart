import 'package:json_annotation/json_annotation.dart';
import 'package:domain/domain.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel {
  final int id;
  final String title;
  final String publisher;
  final String date;
  final String image;
  @JsonKey(name: 'publisher_icon')
  final String? publisherIcon;
  final String category;
  @JsonKey(name: 'is_verified', defaultValue: false)
  final bool? isVerified;
  @JsonKey(name: 'publisher_verified', defaultValue: false)
  final bool? publisherVerified;

  NewsArticleModel({
    required this.id,
    required this.title,
    required this.publisher,
    required this.date,
    required this.image,
    this.publisherIcon,
    required this.category,
    this.isVerified,
    this.publisherVerified,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleModelToJson(this);

  NewsArticleEntity toEntity() {
    return NewsArticleEntity(
      id: id,
      title: title,
      publisher: publisher,
      date: date,
      image: image,
      publisherIcon: publisherIcon ?? '',
      category: category,
      isVerified: isVerified ?? publisherVerified ?? false,
    );
  }
}