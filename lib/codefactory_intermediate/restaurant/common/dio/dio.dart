import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../user/provider/auth_provider.dart';
import '../const/data.dart';
import '../secure_storage/secure_storage.dart';

// 프로바이더를 따로 폴더를 만들어서 관리도 하지만
// 캐싱작업이 필요한 로직이 있는 경우가 아니라면 관련된 변수들이 선언이 되어 있는 파일에서 한꺼번에 관리하는 것도 좋다.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // secureStorageProvider에서 반환해주는 storage
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage, ref: ref),
  );

  return dio;
});

// 토큰 자동관리를 위한 클래스 생성
// intercepter 활용!
// 1) 요청을 보낼때
// 2) 응답을 받을때
// 3) 에러가 났을때

// 인터셉터는 가로채다라는 뜻
// 3가지의 요청을 보낼 때, 중간에 요청 데이터를 가로챈 다음에 또 다른 무언가로 변환해서 반환해준다.

// dio의 요청을 보낼때마다 실행됨
class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  // Ref를 사용하면 riverpod의 모든 ref들을 읽어들일 수 있음.
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  // 1) 요청을 보낼때 (참고 - 요청이 보내지기 전의 상태임.)
  // 요청이 보내질때마다
  // 만약에 요청의 Header에 accessToken: true라는 값이 있다면
  // 실제 토큰을 가져와서 (storage에서) Authorization: Bearer $token으로
  // 헤더를 변경한다.

  // 왜이렇게 하냐? 매번 요청을 보낼 로직을 작성할 때마다
  // 토큰을 직접 넣을 순 없으니까!
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 로그 사용법
    // method: 무슨 REST API 요청인지
    // uri: 어떤 url로 요청을 보냈는지
    print('[REQ] [${options.method}] ${options.uri}');

    // headers: 요청의 header 정보를 가져옴
    // @Headers({
    //   'accessToken': 'true',
    // })

    // access 토큰
    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    // refresh 토큰
    if (options.headers['refreshToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  // 어떤 상황을 catch하고 싶은지 생각하는 것이 중요.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을때 (status code)
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을 보낸다.

    // err에서의 requestOptions는
    // onRequest의 requestOptions와 동일하다.
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refresh 토큰이 아예 없으면
    // 당연히 에러를 던진다.
    if (refreshToken == null) {
      // 에러를 던질 때는 handler.reject()를 사용한다.
      return handler.reject(err);
    }

    // 에러없이 요청을 끝내는 방법
    // response: 응답을 받아온 것을 넣어줘야함
    // return handler.resolve(response);

    // .request 요청의 모든 정보를 가져올 수 있다.
    // .response 응답의 모든 정보를 가져올 수 있다.

    // response? 응답이 없을 수도 있으니까
    // 401 에러는 잘못된 토큰 정보가 왔다는 것을 의미
    final isStatus401 = err.response?.statusCode == 401;
    // 요청을 보낸 path가 /auth/token이라면 true or false
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post('http://$ip/auth/token',
            options: Options(
              headers: {
                'Authorization': 'Bearer $refreshToken',
              },
            ));

        final accessToken = resp.data['accessToken'];

        // 에러가 발생하지 않았다면
        // 에러를 발생시킨 요청의 모든 정보를 가져옴.
        final options = err.requestOptions;

        // 토큰 변경하기
        options.headers.addAll({
          'Authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 에러를 발생시킨 요청의 모든 정보를 가져와서
        // 토큰만 바꾼 다음 (Header 정보)
        // 다시 요청을 보내는 방법.
        // 요청 재전송
        final response = await dio.fetch(options);

        // 요청을 재전송하고 응답이 잘 왔다는 것을 알려주는 방법
        return handler.resolve(response);
      } on DioException catch (e) {
        ref.read(authProvider.notifier).logout();

        // Dio 에러만 잡을거기 때문에.
        // Dio Exception을 사용

        // try에서 에러가 발생하면
        // 더이상 토큰을 refresh 할 수 있는 상황이 아님
        return handler.reject(e);

        // 사실상 리프레쉬 토큰이 없다면 에러를 던질게 아니라
        // 로그아웃을 시켜야함.

        // 단순히 프로바이더를 불러와서 로그아웃을 시키면되지 않냐?
        // CircularDependencyError
        // A, B
        // A -> B의 친구
        // B -> A의 친구
        // A는 B의 친구 (사람 시점)
        // A -> B -> A -> B -> ... (컴퓨터 시점) 도르마무..
        // userMeProvider -> dioProvider -> userMeProvider -> dioProvider -> ...
        // 이럴 때에는 상위에 객체를 하나 더 만들면 된다.
        // authProvider보면 ref에 dio가 없다.
        // ref.read(userMeProvider.notifier).logout();
      }
    }

    return handler.reject(err);
  }
}
