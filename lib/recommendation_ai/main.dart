import 'package:flutter/material.dart';
import 'food_recommendation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '칼로리 기반 음식 추천',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FoodRecommendationScreen(),
    );
  }
}
