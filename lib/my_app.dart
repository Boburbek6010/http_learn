import 'package:flutter/material.dart';
import 'package:http_learn/pages/detail_page.dart';
import 'package:http_learn/pages/home_page.dart';
import 'package:http_learn/pages/login_page.dart';
import 'package:http_learn/setup.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: token != null ?const HomePage() :const LoginPage(),
      routes: {
        HomePage.id:(context) => const HomePage(),
        DetailPage.id:(context) => const DetailPage(),
      },
    );
  }
}