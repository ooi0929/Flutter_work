import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // 모두 Firebase Auth 서버와 통신하기에 비동기 코드로 작성한다.
  // Firebase Auth 서버에서 현재 유저 조회
  User? currentUser() {
    // 현재 유저(로그인 되지 않은 경우 null 반환)
    return FirebaseAuth.instance.currentUser;
  }

  // 회원가입
  void signUp({
    required String email, // 이메일
    required String password, // 비밀번호
    required Function onSuccess, // 가입 성공시 호출 함수
    required Function(String err) onError, // 에러 발생시 호출 함수
  }) async {
    // 회원가입 로직
    // 이메일 및 비밀번호 입력 여부 확인
    if (email.isEmpty) {
      onError('이메일을 입력해주세요.');
      return;
    } else if (password.isEmpty) {
      onError('비밀번호를 입력해주세요.');
      return;
    }

    // firebase auth 회원 가입
    try {
      // 회원가입 성공
      // email과 password로 firebase auth를 이용하여 이메일 회원가입 시도
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 성공 함수 호출
      onSuccess();
    } on FirebaseAuthException catch (e) {
      // 회원가입 실패
      // firebase auth 에러 발생

      // 한국어로 에러 변경
      if (e.code == 'weak-password') {
        onError('비밀번호를 6자리 이상 입력해주세요.');
      } else if (e.code == 'email-already-in-use') {
        onError('이미 가입된 이메일 입니다.');
      } else if (e.code == 'invalid-email') {
        onError('이메일 형식을 확인해주세요.');
      } else if (e.code == 'user-not-found') {
        onError('일치하는 이메일이 없습니다.');
      } else if (e.code == 'wrong-password') {
        onError('비밀번호가 일치하지 않습니다.');
      } else {
        onError(e.message!);
      }
    } catch (e) {
      // 서버와 통신 실패
      // firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }

  // 로그인
  void signIn({
    required String email, // 이메일
    required String password, // 비밀번호
    required Function onSuccess, // 로그인 성공시 호출 함수
    required Function(String err) onError, // 에러 발생시 호출 함수
  }) async {
    // 로그인 로직
    if (email.isEmpty) {
      onError('이메일을 입력해주세요.');
      return;
    } else if (password.isEmpty) {
      onError('비밀번호를 입력해주세요.');
    }

    // 로그인 시도
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 성공 함수 호출
      onSuccess();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // firebase auth 에러 발생
      onError(e.message!);
    } catch (e) {
      // firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }

  // 로그아웃
  void signOut() async {
    // 로그아웃 로직
    await FirebaseAuth.instance.signOut();
    notifyListeners(); // 로그인 상태 변경 알림
  }
}
