import 'package:get/get.dart';
import '../list_items/list_item.dart';
import '../list_items/nav_bar_list_item.dart';
import '../list_items/section_item.dart';
import '../list_items/news_card_item.dart';
import '../list_items/news_horizontal_list_item.dart';
import '../list_items/recommendation_item.dart';
import '../model/news_article.dart';
import '../services/news_service.dart';

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


  Future<void> loadDataFromJson() async {
    try {

      isLoading.value = true;
      errorMessage.value = '';

      final Map<String, dynamic> jsonData = await _newsService.loadNewsData();

      final String userName = jsonData['userName'] ?? 'User';
      final List<dynamic> sectionsJson = jsonData['sections'] ?? [];
      final List<dynamic> articlesJson = jsonData['articles'] ?? [];

      final List<NewsArticle> articles = _newsService.parseArticles(articlesJson);

      _buildItemsList(userName, sectionsJson, articles);

      isLoading.value = false;

    } catch (e) {

      isLoading.value = false;
      errorMessage.value = 'Failed to load news: $e';
      print('Error: $e');
    }
  }

  void _buildItemsList(
      String userName,
      List<dynamic> sectionsJson,
      List<NewsArticle> articles,
      ) {
    items.clear();

    items.add(NavBarListItem(userName: userName));

    if (sectionsJson.isNotEmpty) {
      final section1 = _newsService.parseSection(sectionsJson[0]);
      items.add(SectionItem(
        tag: section1['tag'],
        title: section1['title'],
        rightButtonTitle: section1['rightButtonTitle'],
      ));
    }

    if (articles.length >= 3) {
      items.add(NewsHorizontalListItem(
        newsCards: [
          NewsCardItem(article: articles[0]),
          NewsCardItem(article: articles[1]),
          NewsCardItem(article: articles[2]),
        ],
      ));
    }

    if (sectionsJson.length >= 2) {
      final section2 = _newsService.parseSection(sectionsJson[1]);
      items.add(SectionItem(
        tag: section2['tag'],
        title: section2['title'],
        rightButtonTitle: section2['rightButtonTitle'],
      ));
    }

    if (articles.length >= 4) {
      items.add(RecommendationItem(
        article: articles[3],
        showFollowButton: true,
      ));
    }
  }

  void retry() {
    loadDataFromJson();
  }
}