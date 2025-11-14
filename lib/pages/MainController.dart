import 'package:get/get.dart';
import '../domain/usecases/get_feed_usecase.dart';
import '../list_items/list_item.dart';
import '../list_items/nav_bar_list_item.dart';
import '../list_items/section_item.dart';
import '../list_items/news_card_item.dart';
import '../list_items/news_horizontal_list_item.dart';
import '../list_items/recommendation_item.dart';
import '../model/news_article.dart';
import '../resources/strings.dart';

class MainController extends GetxController {
  final GetFeedUseCase getFeedUseCase;

  MainController({required this.getFeedUseCase});

  RxList<ListItem> items = RxList();
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final feedData = await getFeedUseCase.execute();

      final trendingNews = feedData.trendingNews
          .map((entity) => NewsArticle.fromEntity(entity))
          .toList();

      final recommendations = feedData.recommendations
          .map((entity) => NewsArticle.fromEntity(entity))
          .toList();

      _buildItemsList(
        feedData.user.name,
        trendingNews,
        recommendations,
      );

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load news: ${e.toString()}';
      print('Error: $e');
    }
  }

  void _buildItemsList(
      String userName,
      List<NewsArticle> trendingNews,
      List<NewsArticle> recommendations,
      ) {
    items.clear();

    items.add(NavBarListItem(userName: userName));

    if (trendingNews.isNotEmpty) {
      items.add(SectionItem(
        tag: "trending",
        title: Strings.trendingNews,
        rightButtonTitle: Strings.seeAll,
      ));

      items.add(NewsHorizontalListItem(
        newsCards: trendingNews
            .map((article) => NewsCardItem(article: article))
            .toList(),
      ));
    }

    if (recommendations.isNotEmpty) {
      items.add(SectionItem(
        tag: "recommendation",
        title: Strings.recommendation,
        rightButtonTitle: "",
      ));

      for (var article in recommendations) {
        items.add(RecommendationItem(
          article: article,
          showFollowButton: true,
        ));
      }
    }
  }

  void retry() {
    loadData();
  }
}