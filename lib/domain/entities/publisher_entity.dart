class PublisherEntity {
  final String username;
  final String name;
  final bool verified;
  final String logo;
  final String bio;
  final PublisherStatsEntity stats;
  final bool isFollowing;

  PublisherEntity({
    required this.username,
    required this.name,
    required this.verified,
    required this.logo,
    required this.bio,
    required this.stats,
    required this.isFollowing,
  });
}

class PublisherStatsEntity {
  final String newsCount;
  final String followers;
  final int following;

  PublisherStatsEntity({
    required this.newsCount,
    required this.followers,
    required this.following,
  });
}