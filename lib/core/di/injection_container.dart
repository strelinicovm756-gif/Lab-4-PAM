import 'package:get/get.dart';
import '../../data/datasources/news_remote_datasource.dart';
import '../../data/datasources/news_local_datasource.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/get_feed_usecase.dart';
import '../../domain/usecases/get_publisher_details_usecase.dart';
import '../../pages/MainController.dart';

class InjectionContainer {
  static void init() {
    // Data Sources
    Get.lazyPut<NewsRemoteDataSource>(() => NewsRemoteDataSource());
    Get.lazyPut<NewsLocalDataSource>(() => NewsLocalDataSource());

    // Repository
    Get.lazyPut<NewsRepository>(
          () => NewsRepositoryImpl(
        remoteDataSource: Get.find<NewsRemoteDataSource>(),
        localDataSource: Get.find<NewsLocalDataSource>(),
      ),
    );

    // Use Cases
    Get.lazyPut(() => GetFeedUseCase(Get.find<NewsRepository>()));
    Get.lazyPut(() => GetPublisherDetailsUseCase(Get.find<NewsRepository>()));

    // Controllers
    Get.lazyPut(
          () => MainController(getFeedUseCase: Get.find<GetFeedUseCase>()),
    );
  }
}