import 'package:flutter/material.dart';




class ProgressBarStateStyle extends StatelessWidget {
  final double progress;
  const ProgressBarStateStyle ({
    required this.progress,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[300],
      color: Colors.green,
      minHeight: 6.0,
    );
  }
}


class TugiheButtonStyle extends StatelessWidget {
  const TugiheButtonStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '次へ',
      style: TextStyle(color: Colors.green),
    );
  }
}

