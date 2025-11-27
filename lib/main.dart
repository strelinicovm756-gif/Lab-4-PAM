import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:domain/domain.dart';
import 'package:data/data.dart';

// Import local (UI)
import 'pages/main_page.dart';
import 'pages/MainController.dart';

void main() {
  _initDependencies();
  runApp(const MyApp());
}

void _initDependencies() {
  // Data Source (DOAR remote)
  Get.lazyPut<NewsRemoteDataSource>(() => NewsRemoteDataSource());

  // Repository
  Get.lazyPut<NewsRepository>(
        () => NewsRepositoryImpl(
      remoteDataSource: Get.find<NewsRemoteDataSource>(),
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
      ),
      home: const MainPage(),
    );
  }
}