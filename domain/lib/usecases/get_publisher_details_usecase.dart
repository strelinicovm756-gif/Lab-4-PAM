import '../entities/publisher_details_entity.dart';
import '../repositories/news_repository.dart';

class GetPublisherDetailsUseCase {
  final NewsRepository repository;

  GetPublisherDetailsUseCase(this.repository);

  Future<PublisherDetailsEntity> execute() async {
    return await repository.getPublisherDetails();
  }
}