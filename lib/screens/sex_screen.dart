import 'package:flutter/material.dart';
import 'package:weight_control/component/okarada_color.dart';
import '../component/app_bar_design.dart';
import 'package:weight_control/user_data_creator/User_Data_Creator.dart';

class SexScreen extends StatefulWidget {
  const SexScreen({super.key});

  @override
  State<SexScreen> createState() => _SexScreenState();
}

class _SexScreenState extends State<SexScreen> {
  String selectedGender = '';
  String male = 'male';
  String female = 'female';
  late UserValue userValue;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
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
            Navigator.of(context).maybePop();
          },
        ),
        title: LinearProgressIndicator(
          value: 0.05,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
          minHeight: 6.0,
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
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 30.0,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                _Sex_Icon_Image(),
                _BodyText(),
                _IconSelect(
                  onMalePressed: onMaleButtonPressed,
                  onFemalePressed: onFemaleButtonPressed,
                  male: male,
                  female: female,
                  selectedGender: selectedGender,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onMaleButtonPressed() {
    setState(() {
      selectedGender = male;
      userValue = userValue.copyWith(
        sex: selectedGender,
        userGenderColor: okaradaGreenColor,
      );

      Navigator.of(context).pushNamed(
        '/birthday',
        arguments: userValue,
      );

      print('name: ${userValue.nickname}, sex: ${userValue.sex}');
    });
  }

  onFemaleButtonPressed() {
    setState(() {
      selectedGender = female;
      userValue = userValue.copyWith(
        sex: selectedGender,
        userGenderColor: okaradaPinkColor,
      );
      Navigator.of(context).pushNamed(
        '/birthday',
        arguments: userValue,
      );

      print('name: ${userValue.nickname}, sex: ${userValue.sex}');
    });
  }
}

class _Sex_Icon_Image extends StatelessWidget {
  const _Sex_Icon_Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/sex_image/sex_Icon.png',
      scale: 1.1,
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: const [
          Text(
            'とても、素晴らしい名前ですね！',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'さて、性別を選んでください！',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _IconSelect extends StatelessWidget {
  final VoidCallback onMalePressed;
  final VoidCallback onFemalePressed;
  final String male;
  final String female;
  final String selectedGender;

  const _IconSelect(
      {required this.onMalePressed,
      required this.onFemalePressed,
      required this.male,
      required this.female,
      required this.selectedGender,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 240,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                child: Image.asset(
                  'asset/sex_image/up_arrow.png',
                  scale: 11,
                ),
              ),
              Positioned(
                top: 45,
                child: ElevatedButton(
                  onPressed: onMalePressed,
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: const Size(
                      150,
                      150,
                    ),
                    shape: CircleBorder(),
                    backgroundColor: selectedGender == male
                        ? okaradaGreenColor
                        : Colors.white,
                    side: const BorderSide(
                      color: okaradaGreenColor,
                      width: 8,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Text(
                      '男性',
                      style: TextStyle(
                          color: selectedGender == male
                              ? Colors.white
                              : okaradaGreenColor,
                          fontSize: 27,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        SizedBox(
          width: 150,
          height: 240,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 45,
                child: ElevatedButton(
                  onPressed: onFemalePressed,
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: Size(150, 150),
                    shape: CircleBorder(),
                    backgroundColor: selectedGender == female
                        ? okaradaPinkColor
                        : Colors.white,
                    side: const BorderSide(color: okaradaPinkColor, width: 8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      '女性',
                      style: TextStyle(
                          color: selectedGender == female
                              ? Colors.white
                              : okaradaPinkColor,
                          fontSize: 27,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                child: Image.asset(
                  'asset/sex_image/cross.png',
                  scale: 11,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
