import 'package:get/get.dart';
import 'package:domain/domain.dart';

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

      print('MainController: Loading feed data...');

      final feedResult = await getFeedUseCase.execute();

      print('MainController: Received ${feedResult.trendingNews.length} trending news');
      print('MainController: Received ${feedResult.recommendations.length} recommendations');

      final trendingNews = feedResult.trendingNews
          .map((entity) => NewsArticle.fromEntity(entity))
          .toList();


      final recommendations = feedResult.recommendations
          .map((entity) => NewsArticle.fromEntity(entity))
          .toList();

      _buildItemsList(
        'User',
        trendingNews,
        recommendations,
      );

      isLoading.value = false;
      print('MainController: Feed loaded successfully with ${items.length} items');
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load news: ${e.toString()}';
      print('MainController Error: $e');
    }
  }

  void _buildItemsList(
      String userName,
      List<NewsArticle> trendingNews,
      List<NewsArticle> recommendations,
      ) {
    items.clear();

    // Top Nav Bar
    items.add(NavBarListItem(userName: userName));

    // Trending Section
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

    // Recommendations Section
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

    print('Items list built: ${items.length} items');
  }

  void retry() {
    print('Retrying to load feed...');
    loadData();
  }
}