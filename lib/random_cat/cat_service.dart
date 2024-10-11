import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatService extends ChangeNotifier {
  // 고양이 사진 담을 변수
  List<String> catImages = [];

  // 좋아요 사진
  List<String> favoriteImages = [];

  // SharedPreferences 인스턴스
  late SharedPreferences prefs;

  // 생성자(Constructor)
  CatService() {
    _saveManager(); // Save 매니저 호출
  }

  // SharedPreferences Manager
  Future<void> _saveManager() async {
    // 비동기 방식 -> 동기 방식으로 전환
    await _initPrefs();
    await _getRandomCatImages(); // api 호출

    notifyListeners(); // 데이터가 완전히 준비된 후 UI 업데이트
  }

  // SharedPreferences 초기화
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    // favorites로 저장된 favoriteImages를 가져온다.
    // 저장된 값이 없는 경우 null을 반환하므로 이때는 빈 배열을 넣어준다.
    favoriteImages = prefs.getStringList('favorites') ?? [];
  }

  // 랜덤 고양이 사진 API 호출
  Future<void> _getRandomCatImages() async {
    var result = await Dio().get(
        'https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg');

    for (int i = 0; i < result.data.length; i++) {
      var map = result.data[i]; // 반복문을 돌며 i번째의 map에 접근
      catImages.add(map['url']); // catImages에 이미지 추가
    }

    notifyListeners(); // 새로고침
  }

  // 좋아요 토글
  void toggleFavoriteImage(String catImage) {
    if (favoriteImages.contains(catImage)) {
      favoriteImages.remove(catImage); // 이미 좋아요한 경우 제거
    } else {
      favoriteImages.add(catImage); // 새로운 사진 추가
    }

    // favoriteImages를 favorites라는 이름으로 저장하기
    prefs.setStringList('favorites', favoriteImages);

    notifyListeners(); // 새로고침
  }
}
