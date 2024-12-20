import 'package:flutter_riverpod/flutter_riverpod.dart';

// [3] - 자주 쓰이진 않음
// 기본형태는 모두 동일한 것을 확인 (ref) => 반환값
// 단, <>과 반환값만이 다를 뿐이다.
final multipleFutureProvider = FutureProvider<List<int>>((ref) async {
  await Future.delayed(
    Duration(seconds: 2),
  );

  // throw Exception('에러입니다.');

  return [1, 2, 3, 4, 5];
});
