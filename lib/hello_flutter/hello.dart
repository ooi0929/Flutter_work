import 'package:flutter/material.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

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
                  width: 81.0,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: '이메일',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: LinearBorder(),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {},
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
