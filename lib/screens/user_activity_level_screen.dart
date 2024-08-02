import 'package:flutter/material.dart';
import 'package:weight_control/user_data_creator/User_Data_Creator.dart';


class UserActivityLevelScreen extends StatefulWidget {



  const UserActivityLevelScreen({super.key,});

  @override
  State<UserActivityLevelScreen> createState() => _UserActivityLevelScreenState();
}

class _UserActivityLevelScreenState extends State<UserActivityLevelScreen> {

  late UserValue userValue;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userValue = ModalRoute.of(context)!.settings.arguments as UserValue;
  }



  @override
  Widget build(BuildContext context) {
    double bmr = calculateBMR(userValue.sex!, userValue.weight!.toDouble(), userValue.age!, userValue.height!.toDouble());
    double tdee = calculateTDEE(bmr, userValue.activityLevel!);
    double  daily = calculatedailyCalories1(bmr, userValue.activityLevel!, userValue.weightDiffrence!);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const SizedBox(

          height: 6.0,
          child: LinearProgressIndicator(
            value: 0.75,
            backgroundColor: Colors.grey,
            color: Colors.green,
            minHeight: 6.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 여기에 나중에 다음 화면 추가
            },
            child: const Text(
              '次へ',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'ダイエット計画',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _ResultBox(
                title: '基礎代謝量 (BMR)',
                value: '${bmr.toStringAsFixed(2)} kcal/day',
              ),
              const SizedBox(height: 16),
              _ResultBox(
                title: '1日の総エネルギー消費量 (TDEE)',
                value: '${tdee.toStringAsFixed(2)} kcal/day',
              ),
              const SizedBox(height: 16),
              _ResultBox(
                title: '目標体重のための1日の摂取量 (daily)',
                value: '${daily.toStringAsFixed(2)} kcal/day',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed:() => onNextPageButtonPressed(daily),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  '次へ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    }


  double calculateBMR(String gender, double weight, int age, double height) {
    switch (gender) {
      case 'male':
        return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      case 'female':
        return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      default:
        return 0.0; // 기본값 반환
    }
  }

  double calculateTDEE(double bmr, String activityLevel) {
    switch (activityLevel) {
      case 'sedentary':
        return bmr * 1.2;
      case 'lightActivity':
        return bmr * 1.375;
      case 'moderateActivity':
        return bmr * 1.55;
      case 'veryActive':
        return bmr * 1.725;
      case 'extremelyActive':
        return bmr * 1.9;
      default:
        return bmr * 1.2;
    }
  }

  double calculatedailyCalories1(double bmr, String activityLevel, int weightDifference) {
    switch (activityLevel) {
      case 'sedentary':
        return bmr * 1.2 - (weightDifference)*7700/90 ;
      case 'lightActivity':
        return bmr * 1.375 - (weightDifference)*7700/90;
      case 'moderateActivity':
        return bmr * 1.55 - (weightDifference)*7700/90;
      case 'veryActive':
        return bmr * 1.725 - (weightDifference)*7700/90;
      case 'extremelyActive':
        return bmr * 1.9 - (weightDifference)*7700/90;
      default:
        return bmr * 1.2 -(weightDifference)*7700/90;
    }
  }

  onNextPageButtonPressed(double daily) {
    int dailyKcal = daily.toInt();
    userValue = userValue.copyWith(dailyKcal: dailyKcal);

    setState(() {
      Navigator.of(context).pushNamed('/food-recommendation',
        arguments: userValue,
      );
      print('nickname: ${userValue.nickname}, sex: ${userValue.sex}, age: ${userValue.age}, height: ${userValue.height}, weight: ${userValue.weight}, weightDifference: ${userValue.weightDiffrence}, activityLevel: ${userValue.activityLevel}, dailyKcal: ${userValue.dailyKcal}');
    });
  }
}

class _ResultBox extends StatelessWidget {
  final String title;
  final String value;

  const _ResultBox({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
