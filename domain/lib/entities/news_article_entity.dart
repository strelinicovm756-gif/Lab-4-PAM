class NewsArticleEntity {
  final int id;
  final String title;
  final String publisher;
  final String date;
  final String image;
  final String publisherIcon;
  final String category;
  final bool isVerified;

  NewsArticleEntity({
    required this.id,
    required this.title,
    required this.publisher,
    required this.date,
    required this.image,
    required this.publisherIcon,
    required this.category,
    required this.isVerified,
  });
}