import 'package:flutter/material.dart';
import 'package:http_learn/pages/detail_page.dart';
import 'package:http_learn/pages/home_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        HomePage.id:(context) => const HomePage(),
        DetailPage.id:(context) => const DetailPage(),
      },
    );
  }
}
