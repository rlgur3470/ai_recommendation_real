import 'package:flutter/material.dart';
import 'package:weight_control/user_data_creator/User_Data_Creator.dart';
import 'package:animated_weight_picker/animated_weight_picker.dart';
import '../component/app_bar_design.dart';

class UserWeightScreen extends StatefulWidget {
  const UserWeightScreen({super.key});

  @override
  _UserWeightScreenState createState() => _UserWeightScreenState();
}

class _UserWeightScreenState extends State<UserWeightScreen> {
  final TextEditingController _controller = TextEditingController();
  late UserValue userValue;
  int userWeight = 30;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userValue = ModalRoute.of(context)!.settings.arguments as UserValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              _InfoArea(
                userGenderColor: userValue.userGenderColor!,
              ),
              SizedBox(
                height: 10,
              ),
              _SelectedWeight(
                userGenderColor: userValue.userGenderColor,
                userWeight: userWeight.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              _PickWeight(
                onChanged: (userValue) {
                  setState(() {
                    userWeight = int.parse(userValue);
                  });
                },
                userGenderColor: userValue.userGenderColor!,
              ),
              SizedBox(
                height: 25,
              ),
              _NextPageButton(
                onPressed: moveToNextPage,
                userGenderColor: userValue.userGenderColor!,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: ProgressBarStateStyle(
        progress: 0.44,
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const TugiheButtonStyle(),
        )
      ],
    );
  }

  int userWeightValue(userValue) {
    return userWeight = int.parse(userValue);
  }

  moveToNextPage() {
    setState(() {
      userValue = userValue.copyWith(weight: userWeight);
      Navigator.pushNamed(
        context,
        '/weight-input',
        arguments: userValue,
      );
      print(
          'nickname: ${userValue.nickname}, sex: ${userValue.sex}, age: ${userValue.age}, height: ${userValue.height}, weight: ${userValue.weight}');
    });
  }
}

//module which can textInput by typing
// class _WeightInputText extends StatelessWidget {
//   final TextEditingController controller;
//   const _WeightInputText({required this.controller, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 15),
//               child: Container(
//                 width: 100,
//                 height: 30,
//                 child: TextField(
//                   cursorColor: Colors.green,
//                   cursorHeight: 20,
//                   maxLength: 3,
//                   controller: controller,
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 25),
//                   decoration: const InputDecoration(
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.green,
//                         ),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.green, width: 2),
//                       ),
//                       border: InputBorder.none,
//                       hintText: '3桁以内に',
//                       hintStyle: TextStyle(fontSize: 15, height: 2),
//                       counterText: ''),
//                 ),
//               ),
//             ),
//             const Text(
//               'kg',
//               style: TextStyle(fontSize: 24, color: Colors.grey),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class _SelectedWeight extends StatelessWidget {
  final userGenderColor;
  final userWeight;
  const _SelectedWeight({
    required this.userGenderColor,
    required this.userWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '体重：',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: userGenderColor, width: 3),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            userWeight,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: userGenderColor,
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'kg',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _InfoArea extends StatelessWidget {
  final Color userGenderColor;
  const _InfoArea({required this.userGenderColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          'あなたの体重を教えて下さい?',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        Text(
          textAlign: TextAlign.center,
          '大体でもOKです。',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 1,
        ),
      ],
    );
  }
}

class _PickWeight extends StatelessWidget {
  final Function(String value)? onChanged;
  final Color userGenderColor;

  _PickWeight({
    required this.onChanged,
    required this.userGenderColor,
    super.key,
  });

  int? userWeightValue;

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
          min: 30,
          max: 120,
          onChange: onChanged),
    );
  }
}

class _NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color userGenderColor;
  const _NextPageButton(
      {required this.onPressed, required this.userGenderColor, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: userGenderColor,
      ),
      child: const Text(
        '次へ',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
