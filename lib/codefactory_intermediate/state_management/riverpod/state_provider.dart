import 'package:flutter_riverpod/flutter_riverpod.dart';

// [1]
// StateProvider 관리하고 싶은 값을 반환
// ref: 추후에
// <>: 관리하고 싶은 타입
final numberProvider = StateProvider<int>((ref) => 0);
