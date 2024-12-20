import 'package:flutter_riverpod/flutter_riverpod.dart';

// [5]
// Modifier는 총 두가지이다.
// 1. family
// 2. autoDispose

// 우선은 family부터 FutureProvider를 예시로 시작
// 모두 동일한데 family를 넣는 순간 두 번째 파라미터와 <>를 받게 된다.

// family modifier
// 프로바이더를 생성을 할 때
// 값을 입력하게 되는데
// 값을 통해서 프로바이더 안의 로직을 변경해야 할 때에 사용한다.
final familyModifierProvider =
    FutureProvider.family<List<int>, int>((ref, data) async {
  await Future.delayed(Duration(seconds: 2));

  return List.generate(5, (index) => index * data);
});
