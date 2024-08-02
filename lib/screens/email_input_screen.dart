

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component/app_bar_design.dart';


class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key});

  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;
  bool _subscribeToEmails = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkButtonState);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkButtonState() {
    setState(() {
      String email = _controller.text.trim();
      bool isValidEmail =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
      _isButtonEnabled = email.isNotEmpty && isValidEmail;
    });
  }

  void _toggleSubscribeChanged(bool) {
    setState(() {
      _subscribeToEmails = !_subscribeToEmails;
    });
  }

  void _toggleSubscribe() {
    setState(() {
      _subscribeToEmails = !_subscribeToEmails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: ProgressBarStateStyle(
          progress: 0.62,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height:100
              ),
              Icon(
                Icons.mail,
                size: 100.0,
                color: Colors.green,
              ),
              SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: _EmailInput(
                  controller: _controller,
                  subscribeToEmails: _subscribeToEmails,
                  onChanged: _toggleSubscribeChanged,
                  onTap: _toggleSubscribe,
                ),
              ),
              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  Navigator.pushNamed(context, '/weight-input');
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  '次へ',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final TextEditingController controller;
  final bool subscribeToEmails;
  final ValueChanged onChanged;
  final VoidCallback onTap;

  const _EmailInput(
      {required this.controller,
        required this.subscribeToEmails,
        required this.onChanged,
        required this.onTap,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'メールアドレス',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
              ),
              TextField(
                cursorColor: Colors.lightGreen,
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: subscribeToEmails,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: Colors.green,
            ),
            GestureDetector(
              onTap: onTap,
              child: const Text(
                '健康に関する情報やイベントメールを受け取る',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
