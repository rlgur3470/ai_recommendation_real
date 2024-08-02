import 'package:flutter/material.dart';
import 'calendar_screen.dart';

class FinishedScreen extends StatelessWidget {
  final String selectedCuisine;
  final int recommendedCalories;

  const FinishedScreen({
    required this.selectedCuisine,
    required this.recommendedCalories,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기 버튼의 동작 정의
          },
        ),
        backgroundColor: Colors.white, // AppBar 배경색 설정
      ),
      backgroundColor: Colors.white, // 배경색 설정
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '皆さんのための全ての設定が完了しました！',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70),
              Text(
                'これで毎日、カスタマイズされた食事プランを\n簡単に確認できます！',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarScreen(
                        selectedCuisine: selectedCuisine,
                        recommendedCalories: recommendedCalories,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3EB489),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'もっと見る',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 40),
              Column(
                children: <Widget>[
                  Text(
                    '私たちOKARADAは',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'あなたの成功するダイエットを応援します 😊',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1),
                  Image.asset(
                    'asset/image/okarada_logo.png', // 로고 이미지 경로
                    height: 250,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
