// 프로바이더는 한 곳에 모아놧지만
// 디스크 스토리지는 파일로 따로 관리하는 것도 보여줌.
// 이것도 한곳에 모아놔도 괜찮음
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());