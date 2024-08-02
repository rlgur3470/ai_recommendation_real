import 'package:flutter/material.dart';
import 'package:weight_control/component/app_bar_design.dart';
import 'package:weight_control/user_data_creator/User_Data_Creator.dart';

class PerposeScreen extends StatefulWidget {
  const PerposeScreen({super.key});

  @override
  State<PerposeScreen> createState() => _PerposeScreenState();
}

class _PerposeScreenState extends State<PerposeScreen> {
  final diet = 'diet';
  final makeBody = 'makebody';
  final healthCare = 'healthcare';
  final notIncluded = 'notincluded';
  String? state;

  late UserValue userValue;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userValue = ModalRoute.of(context)!.settings.arguments as UserValue;
  }


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
          progress: 0.12,
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
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20.0),
                const _TargetIcon(),
                const _WeightText(),
                _SelectIcon(
                  diet: diet,
                  makeBody: makeBody,
                  healthCare: healthCare,
                  notIncluded: notIncluded,
                  state: state,
                  onDietPressed: onDietButtonPressed,
                  onMakeBodyPressed: onMakeBodyButtonPressed,
                  onHealthCarePressed: onHealthCareButtonPressed,
                  onNotIncludedPressed: onNotIncludedButtonPressed,
                ),
                _NextPageButton(
                    onPressed: onNextPageButtonPressed
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onDietButtonPressed(){
    setState(() {
      state = diet;
    });
  }
  onMakeBodyButtonPressed(){
    setState(() {
      state = makeBody;
    });
  }

  onHealthCareButtonPressed(){
    setState(() {
      state = healthCare;
    });
  }
  onNotIncludedButtonPressed(){
    setState(() {
      state = notIncluded;
    });
  }

  onNextPageButtonPressed(){
    userValue = userValue.copyWith(purpose: state);

    Navigator.of(context).pushNamed(
      '/nickname',
      arguments: userValue,
    );

    print('sex:${userValue.sex},purpose:${userValue.purpose}');
  }
}


class _TargetIcon extends StatelessWidget {
  const _TargetIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.ads_click,
      color: Colors.green,
      size: 100.0,
    );
  }
}

class _WeightText extends StatelessWidget {
  const _WeightText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      textAlign: TextAlign.center,
      'あなたの目標は？',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SelectIcon extends StatelessWidget {
  final String? diet;
  final String? makeBody;
  final String? healthCare;
  final String? notIncluded;
  String? state;
  final VoidCallback onDietPressed;
  final VoidCallback onMakeBodyPressed;
  final VoidCallback onHealthCarePressed;
  final VoidCallback onNotIncludedPressed;

  _SelectIcon(
      {required this.diet,
        required this.makeBody,
        required this.healthCare,
        required this.notIncluded,
        required this.state,
        required this.onDietPressed,
        required this.onMakeBodyPressed,
        required this.onHealthCarePressed,
        required this.onNotIncludedPressed,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: onDietPressed,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                backgroundColor: state == diet ? Colors.green : Colors.white,
                side: const BorderSide(color: Colors.green),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.monitor_weight,
                    size: 50,
                    color: state == diet ? Colors.white : Colors.green,
                  ),
                  Text(
                    'ダイエット',
                    style: TextStyle(
                        color: state == diet ? Colors.white : Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            OutlinedButton(
              onPressed: onMakeBodyPressed,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                backgroundColor:
                state == makeBody ? Colors.green : Colors.white,
                side: const BorderSide(color: Colors.green),
              ),
              child: Column(
                children: [
                  Icon(Icons.settings_accessibility,
                      color: state == makeBody ? Colors.white : Colors.green,
                      size: 50),
                  Text(
                    'ボディメイク',
                    style: TextStyle(
                        color: state == makeBody ? Colors.white : Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: onHealthCarePressed,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                backgroundColor:
                state == healthCare ? Colors.green : Colors.white,
                side: const BorderSide(color: Colors.green),
              ),
              child: Column(
                children: [
                  Icon(Icons.health_and_safety,
                      color: state == healthCare ? Colors.white : Colors.green,
                      size: 50),
                  Text(
                    '健康管理',
                    style: TextStyle(
                        color:
                        state == healthCare ? Colors.white : Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 40.0,
            ),
            OutlinedButton(
              onPressed: onNotIncludedPressed,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(150, 150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                backgroundColor:
                state == notIncluded ? Colors.green : Colors.white,
                side: const BorderSide(color: Colors.green),
              ),
              child: Column(
                children: [
                  Icon(Icons.interests,
                      color: state == notIncluded ? Colors.white : Colors.green,
                      size: 50),
                  Text(
                    'その他',
                    style: TextStyle(
                        color:
                        state == notIncluded ? Colors.white : Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        )
      ],
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
        child: const Text(
          '次へ',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ));
  }
}
