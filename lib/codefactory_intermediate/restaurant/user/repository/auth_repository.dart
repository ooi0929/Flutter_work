import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/login_response.dart';
import '../../common/model/token_response.dart';
import '../../common/utils/data_utils.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return AuthRepository(dio: dio, baseUrl: 'http://$ip/auth');
  },
);

// 여기서는 retrofit을 사용하지 않고 해봅시다.
// http://$ip/auth -> baseUrl
class AuthRepository {
  final Dio dio;
  final String baseUrl;

  AuthRepository({
    required this.dio,
    required this.baseUrl,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(headers: {
        'Authorization': 'Basic $serialized',
      }),
    );

    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        headers: {
          'refreshToken': true,
        },
      ),
    );

    return TokenResponse.fromJson(resp.data);
  }
}
