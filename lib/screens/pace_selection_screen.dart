import 'package:flutter/material.dart';

import '../component/app_bar_design.dart';

class PaceSelectionScreen extends StatefulWidget {
  const PaceSelectionScreen({super.key});

  @override
  State<PaceSelectionScreen> createState() => _PaceSelectionScreenState();
}

class _PaceSelectionScreenState extends State<PaceSelectionScreen> {
  bool isRecommendedSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: ProgressBarStateStyle(
          progress: 0.80,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const TugiheButtonStyle(),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              _IconBuilt(),
              SizedBox(height: 80),
              _MainText(),
              SizedBox(height: 100),
              _SelectPlanButton(
                isRecommendedSelected: isRecommendedSelected,
                onFirstTap: onFirstGestureTap,
                onSecondTap: onSecondGestureTap,
              ),
              _ResultPlanDate(isRecommendedSelected: isRecommendedSelected,),

              _NextPageButton(
                onPressed: onNextPageButtonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onFirstGestureTap() {
    setState(() {
      isRecommendedSelected = true;
    });
  }

  onSecondGestureTap() {
    setState(() {
      isRecommendedSelected = false;
    });
  }

  onNextPageButtonPressed(){
    setState(() {
      Navigator.pushNamed(context, '/approach-selection');
    });
  }
}

class _IconBuilt extends StatelessWidget {
  const _IconBuilt({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.access_time,
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
      'どれくらいのペースでなりたい姿を目指しますか？',
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}

class _SelectPlanButton extends StatelessWidget {
  final bool isRecommendedSelected;
  final GestureTapCallback onFirstTap;
  final GestureTapCallback onSecondTap;

  const _SelectPlanButton(
      {required this.isRecommendedSelected,
        required this.onFirstTap,
        required this.onSecondTap,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onFirstTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9),
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: isRecommendedSelected ? Colors.green[100] : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: Colors.green,
                width: isRecommendedSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'おすすめ',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  '1ヶ月で1.3kg減量ペース',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onSecondTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9),
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: !isRecommendedSelected ? Colors.green[100] : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: Colors.green,
                width: !isRecommendedSelected ? 2 : 1,
              ),
            ),
            child: const Center(
              child: Text(
                '1ヶ月で2.4kg減量ペース',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultPlanDate extends StatelessWidget {
  final bool isRecommendedSelected;
  const _ResultPlanDate({required this.isRecommendedSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_today, color: Colors.green),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: '${calculateTargetDate().split(' ')[0]}',
                    style: const TextStyle(fontSize: 20, color: Colors.teal)),
                TextSpan(
                    text: '年 ',
                    style: const TextStyle(fontSize: 15, color: Colors.black)),
                TextSpan(
                    text: '${calculateTargetDate().split(' ')[1]}',
                    style: const TextStyle(fontSize: 20, color: Colors.teal)),
                TextSpan(
                    text: '月 ',
                    style: const TextStyle(fontSize: 15, color: Colors.black)),
                TextSpan(
                    text: '${calculateTargetDate().split(' ')[2]}',
                    style: const TextStyle(fontSize: 20, color: Colors.teal)),
                TextSpan(
                    text: '日 達成',
                    style: const TextStyle(fontSize: 15, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String calculateTargetDate() {
    final now = DateTime.now();
    final targetDate = isRecommendedSelected
        ? DateTime(now.year, now.month + 1, now.day)
        : DateTime(now.year, now.month + 2, now.day);
    return '${targetDate.year} ${targetDate.month} ${targetDate.day}';
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
        foregroundColor: Colors.white, // 버튼 높이 설정
      ),
      child: const Text(
        '次へ',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
