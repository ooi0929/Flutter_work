import 'package:flutter/material.dart';

class HelloFlutter extends StatelessWidget {
  const HelloFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello Flutter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image.network(
                  'https://i.ibb.co/CwzHq4z/trans-logo-512.png',
                  height: 84.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  // 커스텀 위젯을 사용하여 레이블을 표시.
                  label: Text('이메일'),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  // 단순한 텍스트를 레이블로 표시.
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  // ElevatedButton 스타일 지정
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: LinearBorder(),
                  ),
                  onPressed: () {},
                  child: Text('로그인'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
