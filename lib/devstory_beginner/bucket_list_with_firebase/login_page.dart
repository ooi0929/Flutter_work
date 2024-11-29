import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'bucket_list_with_firebase.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    // final user = ValueNotifier(authService.currentUser());

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '로그인',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 현재 유저 로그인 상태
            // ValueListenableBuilder(
            // valueListenable: user,
            Consumer<AuthService>(
              builder: (context, authService, _) {
                final user = authService.currentUser();
                return Center(
                  child: Text(
                    user == null ? '로그인해주세요' : '${user.email}님 안녕하세요.',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32.0),

            // 이메일
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: '이메일'),
            ),

            // 비밀번호
            TextField(
              controller: passwordController,
              obscureText: true, // 비밀번호 가리기
              decoration: InputDecoration(hintText: '비밀번호'),
            ),
            SizedBox(height: 32.0),

            // 로그인 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: LinearBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                // 로그인
                authService.signIn(
                  email: emailController.text,
                  password: passwordController.text,
                  onSuccess: () {
                    // 로그인 성공
                    ScaffoldMessenger.of(context).showSnackBar(
                      // 화면에 보여주기
                      SnackBar(content: Text('로그인 성공')),
                    );

                    // ValueNotifier를 같이 사용시 (주의. 로그아웃 부분도 따로 갱신 시켜야함)
                    // user 값을 업데이트하여 UI를 갱신
                    // user.value = authService.currentUser();

                    // Homepage로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BucketListWithFirebase()),
                    );
                  },
                  onError: (err) {
                    // 에러 발생
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(err)),
                    );
                  },
                );
              },
              child: Text(
                '로그인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // 회원가입 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: LinearBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                // 회원가입
                authService.signUp(
                  email: emailController.text,
                  password: passwordController.text,
                  onSuccess: () {
                    // 회원가입 성공
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('회원가입 성공')),
                    );
                  },
                  onError: (err) {
                    // 에러 발생
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(err)),
                    );
                  },
                );
              },
              child: Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
