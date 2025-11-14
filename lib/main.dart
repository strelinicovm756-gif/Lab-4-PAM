import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/di/injection_container.dart';
import 'pages/main_page.dart';

void main() {
  InjectionContainer.init();
  runApp(const MyApp());
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