import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/news_article_entity.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel {
  final int id;
  final String title;
  final String publisher;
  final String date;
  final String image;
  @JsonKey(name: 'publisher_icon')
  final String? publisherIcon;  // ← SCHIMBAT: Acum e nullable (String?)
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
    this.publisherIcon,  // ← SCHIMBAT: Nu mai e required
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
      publisherIcon: publisherIcon ?? '',  // ← SCHIMBAT: Folosește '' dacă e null
      category: category,
      isVerified: isVerified ?? publisherVerified ?? false,
    );
  }
}