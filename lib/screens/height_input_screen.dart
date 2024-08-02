import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_control/component/okarada_color.dart';
import 'package:weight_control/user_data_creator/User_Data_Creator.dart';
import '../component/app_bar_design.dart';

class HeightInputScreen extends StatefulWidget {
  const HeightInputScreen({super.key});

  @override
  _HeightInputScreenState createState() => _HeightInputScreenState();
}

class _HeightInputScreenState extends State<HeightInputScreen> {

  late UserValue userValue;
  late int height;
  late String userSexImage;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userValue = ModalRoute.of(context)!.settings.arguments as UserValue;
    height = userValue.sex == 'male' ? 170 : 155;
    userSexImage = userValue.sex == 'male'
        ? 'asset/height_image/male_height.png'
        : 'asset/height_image/women_height.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              _infoText(),
              _HeightPicker(
                height: height,
                userSexImage: userSexImage,
                onChanged: (value) => setState(() => height = value),
                userGenderColor: userValue.userGenderColor!,
              ),
              _NextPageButton(
                onPressed: buttonOnPressed,
                buttonColor: userValue.userGenderColor!,
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
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: ProgressBarStateStyle(
        progress: 0.37,
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const TugiheButtonStyle(),
        )
      ],
    );
  }

  buttonOnPressed() {
    setState(() {
      userValue = userValue.copyWith(height: height);
      Navigator.of(context).pushNamed(
        '/user-weight',
        arguments: userValue,
      );
      print(
          'nickname: ${userValue.nickname}, sex: ${userValue.sex}, age: ${userValue.age}, height: ${userValue.height}');
    });
  }
}

class _infoText extends StatelessWidget {
  const _infoText({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'あなたの身長を教えてください！',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HeightPicker extends StatelessWidget {
  final int height;
  final ValueChanged onChanged;
  final Color userGenderColor;
  final String userSexImage;
  const _HeightPicker(
      {required this.height,
      required this.onChanged,
      required this.userGenderColor,
      required this.userSexImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            'asset/height_image/height_measurement.png',
            color: Colors.grey,
            scale: 8.7,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 3,
              ),
              Text(
                textAlign: TextAlign.center,
                '$height cm',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              Image.asset(
                color: userGenderColor,
                userSexImage,
                scale: 4,
              ),
            ],
          ),
          NumberPicker(
            itemCount: 7,
            selectedTextStyle: TextStyle(
                color: userGenderColor,
                fontSize: 25,
                fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
                border: Border.all(color: userGenderColor, width: 3),
                borderRadius: BorderRadius.circular(10.0)),
            minValue: 100,
            maxValue: 250,
            value: height,
            onChanged: onChanged,
            textMapper: (numberText) => numberText + 'cm',
          ),
        ],
      ),
    );
  }
}

class _NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  const _NextPageButton(
      {required this.onPressed, required this.buttonColor, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
      child: const Text(
        '次へ',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
