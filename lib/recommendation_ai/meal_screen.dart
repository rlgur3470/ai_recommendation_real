import 'package:flutter/material.dart';

class MealScreen extends StatelessWidget {
  final String cuisine;
  final String mealTime;
  final String imagePath;
  final Map<String, List<Map<String, dynamic>>> mealData;
  final Widget nextMealScreen;

  const MealScreen({
    required this.cuisine,
    required this.mealTime,
    required this.imagePath,
    required this.mealData,
    required this.nextMealScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> meals = mealData[mealTime] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(_getMealTitle(mealTime)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 170),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.food_bank, size: 40, color: Color(0xFF3EB489)),
                        title: Text(
                          meals[index]['food_name'],
                          style: const TextStyle(color: Color(0xFF3EB489)),
                        ),
                        subtitle: Text(
                          '${meals[index]['calories']} kcal',
                          style: const TextStyle(color: Color(0xFF3EB489)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => nextMealScreen),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3EB489),
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  mealTime == '朝ご飯'
                      ? '昼ご飯へ！'
                      : mealTime == '昼ご飯'
                      ? '夜ご飯へ！'
                      : '次へ！',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  String _getMealTitle(String mealTime) {
    switch (mealTime) {
      case '朝ご飯':
        return '朝ご飯';
      case '昼ご飯':
        return '昼ご飯';
      case '夜ご飯':
        return '夜ご飯';
      default:
        return '';
    }
  }
}
