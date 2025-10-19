import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../list_items/nav_bar_list_item.dart';
import '../list_items/section_item.dart';
import '../list_items/news_horizontal_list_item.dart';
import '../list_items/recommendation_item.dart';
import '../widgets/top_nav_bar_widget.dart';
import '../widgets/section_widget.dart';
import '../widgets/news_horizontal_widget.dart';
import '../widgets/recommendation_widget.dart';
import '../pages/MainController.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => MainController());
  }

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(

        child: Obx(() {

          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading news...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => controller.retry(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.items.length,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemBuilder: (BuildContext context, int index) {
              var item = controller.items[index];

              if (item is NavBarListItem) {
                return TopNavBarWidget(item: item);
              } else if (item is SectionItem) {
                return SectionWidget(
                  item: item,
                  onTap: (String tag) {
                    print('Section tapped: $tag');
                  },
                );
              } else if (item is NewsHorizontalListItem) {
                return NewsHorizontalWidget(item: item);
              } else if (item is RecommendationItem) {
                return RecommendationWidget(item: item);
              }

              return SizedBox.shrink();
            },
          );
        }),
      ),
    );
  }
}