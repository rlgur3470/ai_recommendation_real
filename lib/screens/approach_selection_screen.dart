import 'package:flutter/material.dart';

class ApproachSelectionScreen extends StatefulWidget {
  const ApproachSelectionScreen({super.key});

  @override
  State<ApproachSelectionScreen> createState() =>
      _ApproachSelectionScreenState();
}

class _ApproachSelectionScreenState extends State<ApproachSelectionScreen> {
  String selectedMethod = "balanced";

  Map<String, int> calorieIntake = {
    "diet": 2000,
    "balanced": 2461,
    "exercise": 2700,
  };

  Map<String, int> calorieBurn = {
    "diet": 300,
    "balanced": 379,
    "exercise": 500,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: LinearProgressIndicator(
          value: 1.0,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
          minHeight: 6.0,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 다음 페이지로 이동하는 로직 추가
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100),
              _IconBuild(),
              SizedBox(height: 25),
              _MainText(),
              SizedBox(height: 25),
              _SelectApproach(
                selectedMethod: selectedMethod,
                firstOnTap: firstOnTap,
                secondOnTap: secondOnTap,
                thirdOnTap: thirdOnTap,
              ),
              SizedBox(height: 50,),
              _ResultKcal(
                selectedMethod: selectedMethod,
                calorieIntake: calorieIntake,
                calorieBurn: calorieBurn,
              ),
              _NextPageButton(
                onPressed: onNextPageButtonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  firstOnTap() {
    setState(() {
      selectedMethod = "diet";
    });
  }

  secondOnTap() {
    setState(() {
      selectedMethod = "balanced";
    });
  }

  thirdOnTap() {
    setState(() {
      selectedMethod = "exercise";
    });
  }

  onNextPageButtonPressed() {
    setState(() {
      Navigator.pushNamed(context, '/activity-level');
    }); // 다음 단계로 이동하는 로직 추가
  }
}

class _IconBuild extends StatelessWidget {
  const _IconBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.place,
      size: 100,
      color: Colors.green,
    );
  }
}

class _MainText extends StatelessWidget {
  const _MainText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      '減量へのアプローチ方法は？',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class _SelectApproach extends StatelessWidget {
  final String selectedMethod;
  final VoidCallback firstOnTap;
  final VoidCallback secondOnTap;
  final VoidCallback thirdOnTap;
  const _SelectApproach(
      {required this.selectedMethod,
        required this.firstOnTap,
        required this.secondOnTap,
        required this.thirdOnTap,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: firstOnTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color:
              selectedMethod == "diet" ? Colors.green[100] : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: Colors.green,
                width: selectedMethod == "diet" ? 2 : 1,
              ),
            ),
            child: const Center(
              child: Text(
                '食事中心',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: secondOnTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: selectedMethod == "balanced"
                  ? Colors.green[100]
                  : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: Colors.green,
                width: selectedMethod == "balanced" ? 2 : 1,
              ),
            ),
            child: const Center(
              child: Text(
                '食事と運動バランスよく',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: thirdOnTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: selectedMethod == "exercise"
                  ? Colors.green[100]
                  : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: Colors.green,
                width: selectedMethod == "exercise" ? 2 : 1,
              ),
            ),
            child: const Center(
              child: Text(
                '運動中心',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultKcal extends StatelessWidget {
  final String selectedMethod;
  final Map<String, int> calorieIntake;
  final Map<String, int> calorieBurn;
  const _ResultKcal(
      {required this.selectedMethod,
        required this.calorieIntake,
        required this.calorieBurn,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Icon(Icons.restaurant, color: Colors.green),
              const SizedBox(height: 8),
              const Text(
                '目標摂取カロリー',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                '${calorieIntake[selectedMethod]} kcal',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.local_fire_department, color: Colors.green),
              const SizedBox(height: 8),
              const Text(
                '目標消費カロリー',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                '${calorieBurn[selectedMethod]} kcal',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _NextPageButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      child: const Text(
        '次へ',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
