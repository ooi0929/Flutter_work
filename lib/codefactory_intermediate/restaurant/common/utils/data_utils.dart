// 공통적으로 사용되는 static 메서드들을 여기서 정리
import 'dart:convert';

import '../const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  // List<String>으로 하게되면 반드시 String값으로 리스트를 불러와야 하는데
  // 서버에서는 데이터를 전송해줄 때 어떤 타입인지 모르기에 코드 생성기가 자동으로 dynamic으로 설정하느라
  // 의미가 없어서 반환할 때 String 타입으로 반환되도록 변경하는 코드를 작성한다.
  static List<String> listPathToUrls(List paths) {
    return paths
        .map(
          (e) => pathToUrl(e),
        )
        .toList();
  }

  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);

    return encoded;
  }

  static DateTime stringToDateTime(String value) {
    // DateTime.parse()
    // 안에 들어오는 String값을 기반으로 DateTime 클래스를 생성해준다.
    return DateTime.parse(value);
  }

  // static DateTime stringToDateTime(String value) {
  //   try {
  //     // 기본적으로 ISO-8601 형식을 지원
  //     return DateTime.parse(value);
  //   } catch (_) {
  //     try {
  //       // 커스텀 형식 파싱
  //       final formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');
  //       return formatter.parse(value);
  //     } catch (e) {
  //       throw FormatException('Invalid DateTime format: $value');
  //     }
  //   }
  // }
}
