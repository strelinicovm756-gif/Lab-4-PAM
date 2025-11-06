import 'package:get/get.dart';
import '../list_items/list_item.dart';
import '../list_items/nav_bar_list_item.dart';
import '../list_items/section_item.dart';
import '../list_items/news_card_item.dart';
import '../list_items/news_horizontal_list_item.dart';
import '../list_items/recommendation_item.dart';
import '../model/news_article.dart';
import '../services/news_service.dart';
import '../resources/strings.dart';

class MainController extends GetxController {
  final NewsService _newsService = NewsService();

  RxList<ListItem> items = RxList();
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDataFromJson();
  }

  // Încărcare asincronă din JSON
  Future<void> loadDataFromJson() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Încarcă JSON
      final Map<String, dynamic> jsonData = await _newsService.loadNewsData();

      // Parse date
      final String userName = _newsService.parseUserName(jsonData['user']);
      final List<NewsArticle> trendingNews = _newsService.parseTrendingNews(jsonData['trending_news']);
      final List<NewsArticle> recommendations = _newsService.parseRecommendations(jsonData['recommendations']);

      // Construiește lista
      _buildItemsList(userName, trendingNews, recommendations);

      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load news: $e';
      print('Error: $e');
    }
  }

  // Construire listă items
  void _buildItemsList(
      String userName,
      List<NewsArticle> trendingNews,
      List<NewsArticle> recommendations,
      ) {
    items.clear();

    // Nav Bar
    items.add(NavBarListItem(userName: userName));

    // Trending Section
    if (trendingNews.isNotEmpty) {
      items.add(SectionItem(
        tag: "trending",
        title: Strings.trendingNews,
        rightButtonTitle: Strings.seeAll,
      ));

      // Trending News Cards
      items.add(NewsHorizontalListItem(
        newsCards: trendingNews
            .map((article) => NewsCardItem(article: article))
            .toList(),
      ));
    }

    // Recommendation Section
    if (recommendations.isNotEmpty) {
      items.add(SectionItem(
        tag: "recommendation",
        title: Strings.recommendation,
        rightButtonTitle: "",
      ));

      // Recommendation Cards
      for (var article in recommendations) {
        items.add(RecommendationItem(
          article: article,
          showFollowButton: true,
        ));
      }
    }
  }
  // Retry
  void retry() {
    loadDataFromJson();
  }
}