import 'package:flutter_riverpod/flutter_riverpod.dart';

// [6]
// autoDispose는 새로운 값을 받지 않는다. (알아서 값을 생성하고 삭제해준다.)

// 값을 사용하지 않을 때에 메모리에서 삭제해야할 떼에는 autoDispose를 사용한다.
final autoDisposeModifierProvider =
    FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return [1, 2, 3, 4, 5];
});
