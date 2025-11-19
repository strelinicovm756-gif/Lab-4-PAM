// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article_model.dart';

// JsonSerializableGenerator

NewsArticleModel _$NewsArticleModelFromJson(Map<String, dynamic> json) =>
    NewsArticleModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      publisher: json['publisher'] as String,
      date: json['date'] as String,
      image: json['image'] as String,
      publisherIcon: json['publisher_icon'] as String?,
      category: json['category'] as String,
      isVerified: json['is_verified'] as bool? ?? false,
      publisherVerified: json['publisher_verified'] as bool? ?? false,
    );

Map<String, dynamic> _$NewsArticleModelToJson(NewsArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'publisher': instance.publisher,
      'date': instance.date,
      'image': instance.image,
      'publisher_icon': instance.publisherIcon,
      'category': instance.category,
      'is_verified': instance.isVerified,
      'publisher_verified': instance.publisherVerified,
    };
