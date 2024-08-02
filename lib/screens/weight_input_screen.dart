import 'package:flutter/material.dart';
import 'package:weight_control/user_data_creator/User_Data_Creator.dart';
import '../component/app_bar_design.dart';
import 'package:animated_weight_picker/animated_weight_picker.dart';

class WeightInputScreen extends StatefulWidget {
  const WeightInputScreen({super.key});

  @override
  State<WeightInputScreen> createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
  final int initialWeight = 0;
  final TextEditingController _currentWeightController =
      TextEditingController();
  final TextEditingController _goalWeightController = TextEditingController();
  late UserValue userValue;
  late double userWeight;
  late Color userGenderColor;
  double targetWeight = 0;
  late double weightDifference;
  final double minWeight = 0;
  late double maxWeight;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userValue = ModalRoute.of(context)!.settings.arguments as UserValue;
    _currentWeightController.text = userValue.weight.toString();
    userWeight = userValue.weight!.toDouble();
    maxWeight = userValue.weight!.toDouble();
    userGenderColor = userValue.userGenderColor!;
    weightDifference = userWeight - minWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: ProgressBarStateStyle(
          progress: 0.63,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TextField(),
              _WeightChange(
                userGenderColor: userGenderColor,
                userGender: userValue.sex!,
                userWeight: userWeight,
                targetWeight: targetWeight,
                weightDifference: weightDifference,
              ),
              _WeightPicker(
                userGenderColor: userGenderColor,
                minWeight: minWeight,
                maxWeight: maxWeight,
                onChange: (String value) {
                  setState(() {
                    targetWeight = double.parse(value);

                    weightDifference = (userWeight - targetWeight).abs();
                  });
                },
              ),
              _NextPagebutton(
                onPressed: onNextButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: userGenderColor,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onNextButtonPressed() {
    setState(() {
      userValue = userValue.copyWith(weightDiffrence: weightDifference.round());
      Navigator.pushNamed(
        context,
        '/activity-level',
        arguments: userValue,
      );
      print(
          'nickname: ${userValue.nickname}, sex: ${userValue.sex}, age: ${userValue.age}, height: ${userValue.height}, weight: ${userValue.weight}, weightDifference: ${userValue.weightDiffrence}');
    });
  }
}

class _TextField extends StatelessWidget {
  const _TextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: const Text(
            '目標体重を教えて下さい！',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: const Text(
            '最初は、２ヶ月後を目標にしましょう。',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

// class _WeightChange extends StatelessWidget {
//   final TextEditingController currentController;
//   final TextEditingController goalWeightController;
//   const _WeightChange(
//       {required this.currentController,
//       required this.goalWeightController,
//       super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Flexible(
//           child: Container(
//             width: 150,
//             height: 30,
//             child: TextField(
//               cursorColor: Colors.green,
//               cursorHeight: 20,
//               maxLength: 3,
//               controller: currentController,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 24),
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.green,
//                     ),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.green, width: 2),
//                   ),
//                   border: InputBorder.none,
//                   suffixStyle: TextStyle(fontSize: 24),
//                   hintText: '今の体重',
//                   hintStyle: TextStyle(fontSize: 15, height: 2),
//                   counterText: ''),
//             ),
//           ),
//         ),
//         Text(
//           'KG',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
//         ),
//         SizedBox(width: 10),
//         Icon(Icons.arrow_forward, size: 36),
//         SizedBox(width: 10),
//         Flexible(
//           child: Container(
//             width: 150,
//             height: 30,
//             child: TextField(
//               cursorColor: Colors.green,
//               cursorHeight: 20,
//               maxLength: 3,
//               controller: goalWeightController,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 24),
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.green,
//                     ),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.green, width: 2),
//                   ),
//                   border: InputBorder.none,
//                   hintText: '目指せる体重',
//                   hintStyle: TextStyle(fontSize: 15, height: 2),
//                   counterText: ''),
//             ),
//           ),
//         ),
//         Text(
//           'KG',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
//         ),
//       ],
//     );
//   }
// }

class _WeightChange extends StatelessWidget {
  final Color userGenderColor;
  final String userGender;
  final double userWeight;
  final double targetWeight;
  final double weightDifference;
  const _WeightChange({
    required this.userGenderColor,
    required this.userGender,
    required this.userWeight,
    required this.targetWeight,
    required this.weightDifference,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                userGender == 'male'
                    ? 'asset/height_image/male_height.png'
                    : 'asset/height_image/women_height.png',
                scale: 7,
                color: Colors.grey,
              ),
              Text(
                '${userWeight.toInt()}kg',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 90,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: userGenderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    userWeight > targetWeight
                        ? '-${weightDifference.toInt()}kg'
                        : '+${weightDifference.toInt()}kg',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: userGenderColor,
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 50,
                color: userGenderColor,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                userGender == 'male'
                    ? 'asset/height_image/male_height.png'
                    : 'asset/height_image/women_height.png',
                scale: userWeight < targetWeight ? 6 : 8,
                color: userGenderColor,
              ),
              Text(
                '${targetWeight.toInt()}kg',
                style: TextStyle(
                    color: userGenderColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _WeightPicker extends StatelessWidget {
  final Color userGenderColor;
  final double minWeight;
  final double maxWeight;
  final Function(String value) onChange;
  const _WeightPicker({
    required this.userGenderColor,
    required this.minWeight,
    required this.maxWeight,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: AnimatedWeightPicker(
          division: 1.0,
          majorIntervalHeight: 30,
          dialColor: userGenderColor,
          selectedValueColor: userGenderColor,
          suffixTextColor: userGenderColor,
          minorIntervalColor: Colors.black,
          majorIntervalColor: Colors.black,
          majorIntervalTextColor: Colors.black,
          subIntervalColor: Colors.black,
          min: minWeight,
          max: maxWeight,
          onChange: onChange),
    );
  }
}

class _NextPagebutton extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonStyle style;
  const _NextPagebutton(
      {required this.onPressed, required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: const Text(
        '次へ',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
