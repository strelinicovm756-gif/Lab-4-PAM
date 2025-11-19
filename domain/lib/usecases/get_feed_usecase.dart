import '../repositories/news_repository.dart';

class GetFeedUseCase {
  final NewsRepository repository;

  GetFeedUseCase(this.repository);

  Future<FeedResult> execute() async {
    return await repository.getFeed();
  }
}