import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:weight_control/component/app_bar_design.dart';
import 'package:flutter/services.dart';
import 'package:weight_control/user_data_creator/User_Data_Creator.dart';
import 'package:weight_control/component/okarada_color.dart';

class NicknameScreen extends StatefulWidget {
  const NicknameScreen({super.key});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {

  UserValue userValue = UserValue(
    sex: '',
    purpose: '',
    nickname: '',
    age: 0,
    weight: 0,
    height: 0,
    userEmail: '',
    weightDiffrence: 0,
    activityLevel: '',
    dailyKcal: 0,
    userGenderColor: Colors.white,
  );

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ProgressBarStateStyle(
          progress: 0.24,
        ),
        actions: [
          TextButton(
            onPressed: onNextPageButtonPressed,
            child: const TugiheButtonStyle(),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    _Okarada_Logo_Icon(),
                    SizedBox(
                      height: 20,
                    ),
                    _QuestionText(),
                  ],
                ),
                _TextInput(controller: _controller),
                SizedBox(
                  height: 40,
                ),
                _NextPageButton(
                  onPressed: onNextPageButtonPressed,
                  controller: _controller,
                  backColor: _controller.text.isNotEmpty ? okaradaGreenColor : Colors.grey[300]!,
                  foreColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onNextPageButtonPressed(){
    if (_controller.text.isNotEmpty) {
      userValue = userValue.copyWith(nickname: _controller.text);
      Navigator.of(context).pushNamed('/sex',
        arguments: userValue,
      );

      print('nickname:${userValue.nickname}');
    }
  }

  backColorSettings(){
    setState(() {
      _controller.text.isNotEmpty ? okaradaGreenColor : Colors.grey[300];
    });
  }
}

class _Okarada_Logo_Icon extends StatelessWidget {
  const _Okarada_Logo_Icon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/okarada_logo_image/okarada_logo.png',
      scale: 5,
    );
  }
}

class _QuestionText extends StatelessWidget {
  const _QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'どんな名前で呼ばれたいですか？',
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


class _TextInput extends StatelessWidget {
  final TextEditingController controller;

  const _TextInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  height: 30,
                  width: 150,
                  child: TextField(
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    cursorColor: Colors.green,
                    cursorHeight: 20,
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: '10文字以内',
                      hintStyle: TextStyle(
                          fontSize: 18,
                          height: 1.8
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: okaradaGreenColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: okaradaGreenColor, width: 2)
                      ),
                    ),
                    style: TextStyle(fontSize: 25),

                  ),
                ),
              ),
              Text(
                '様',
                style: TextStyle(
                  color: okaradaGreenColor,
                  fontSize: 25,
                ),
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
  final TextEditingController controller;
  final Color backColor;
  final Color foreColor;

  const _NextPageButton({
    required this.onPressed,
    required this.controller, super.key,
    required this.backColor,
    required this.foreColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style:
          ElevatedButton.styleFrom(
            backgroundColor: backColor,
            foregroundColor: foreColor,
          ),
          child: const Text(
            '次へ',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }
}
