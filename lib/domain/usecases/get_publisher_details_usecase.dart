import '../entities/publisher_details_entity.dart';
import '../repositories/news_repository.dart';

class GetPublisherDetailsUseCase {
  final NewsRepository repository;

  GetPublisherDetailsUseCase(this.repository);

  Future<PublisherDetailsEntity> execute() async {
    try {
      return await repository.getPublisherDetails();
    } catch (e) {
      throw Exception('Failed to load publisher details: $e');
    }
  }
}