// 고양이 서비스
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CatService {
  // 고양이 사진 담을 변수
  final ValueNotifier<List<String>> _catImages;
  ValueNotifier<List<String>> get catImage => _catImages;

  // 좋아요 사진
  final ValueNotifier<List<String>> _favoriteImages;
  ValueNotifier<List<String>> get favoriteImages => _favoriteImages;

  // 해당 클래스는 싱글톤 개념.
  static final CatService _instance = CatService._internal();
  static CatService get instance => _instance;

  // 외부에서 인스턴스 생성 막아두기.
  CatService._internal()
      : _catImages = ValueNotifier([]),
        _favoriteImages = ValueNotifier([]);

  // 랜덤 고양이 사진 API 호출
  void getRandomCatImages() async {
    var result = await Dio().get(
        'https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg');

    print(result.data);

    List<String> newCatImages = [];
    for (int i = 0; i < result.data.length; i++) {
      var map = result.data[i]; // 반복문을 돌려 i번째의 map에 접근
      print(map);
      print(map['url']); // url만 추출
      newCatImages.add(map['url']);
    }

    _catImages.value = newCatImages;
  }

  // 좋아요 토글
  void toggleFavoriteImage(String catImage) {
    if (_favoriteImages.value.contains(catImage)) {
      _favoriteImages.value.remove(catImage); // 이미 좋아요한 경우 제거
    } else {
      _favoriteImages.value.add(catImage); // 새로운 사진 추가
    }

    var newFavoriteImages = List<String>.from(_favoriteImages.value);
    _favoriteImages.value = newFavoriteImages;
  }
}
