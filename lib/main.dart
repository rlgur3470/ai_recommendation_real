import 'package:flutter/material.dart';
import 'package:weight_control/recommendation_ai/food_recommendation_screen.dart';
import 'package:weight_control/screens/sex_screen.dart';
import 'package:weight_control/screens/perpose_screen.dart';
import 'package:weight_control/screens/nickname_screen.dart';
import 'package:weight_control/screens/birthday_screen.dart';
import 'package:weight_control/screens/height_input_screen.dart';
import 'package:weight_control/screens/user_weight_screen.dart';
import 'package:weight_control/screens/email_input_screen.dart';
import 'package:weight_control/screens/weight_input_screen.dart';
import 'package:weight_control/screens/pace_selection_screen.dart';
import 'package:weight_control/screens/approach_selection_screen.dart';
import 'package:weight_control/screens/activity_level_screen.dart';
import 'package:weight_control/screens/user_activity_level_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '체중 관리 앱',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const NicknameScreen(),
        '/sex': (context) => const SexScreen(),
        '/perpose': (context) => const PerposeScreen(),
        '/birthday': (context) => const BirthdayScreen(),
        '/height-input': (context) => const HeightInputScreen(),
        '/user-weight': (context) => const UserWeightScreen(),
        '/email-input': (context) => const EmailInputScreen(),
        '/weight-input': (context) => const WeightInputScreen(),
        '/pace-selection': (context) => const PaceSelectionScreen(),
        '/approach-selection': (context) => const ApproachSelectionScreen(),
        '/activity-level': (context) => const ActivityLevelScreen(),
        '/user-activity-level': (context) => const UserActivityLevelScreen(),
        '/food-recommendation' : (context) => const FoodRecommendationScreen()
      },
    );
  }
}
