import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../model/user_model.dart';
import '../provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // 이메일
  String username = '';
  // 비밀번호
  String password = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);

    // api요청을 위한 클래스
    // final dio = Dio();

    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          // manual: Done을 눌러야 키보드가 내려감
          // onDrag: Drag를 해야지만 키보드가 내려감
          // values: 모든 값을 입력해야지만 키보드가 내려감
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16.0),
                _SubTitle(),
                Image.asset(
                  'assets/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  // 네트워크 요청 - 비동기 작업
                  // 로딩하는 동안에는 로그인 버튼을 누를 수 없도록 하는 방법.
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                          // 쉽게 로그인을 할 수 있음.
                          ref
                              .read(userMeProvider.notifier)
                              .login(username: username, password: password);

                          // 여기서는 로그인하면 refresh 토큰과 access 토큰을 발급받는 요청

                          // 사용자 ID:PW
                          // final rawString = '$username:$password';

                          // Base64로 인코딩 (암기)
                          // Codec<> 이용 - String값을 넣고 String값을 반환받겠다.
                          // utf8 - 전세계에서 가장 많이 사용되는 인코딩 Codec.
                          // 아래 코드는 어떻게 인코딩 될 것인지를 정의.
                          // Codec<String, String> stringToBase64 = utf8.fuse(base64);

                          // 인코딩을 정의한 값에 인코딩되길 원하는 값을 넣어서 값을 반환
                          // String token = stringToBase64.encode(rawString);

                          // dio를 통해서 API 요청
                          // path: 경로 (api 엔드포인트)
                          // options: 요청 보낼때의 옵션값을 지정 가능
                          // final resp = await dio.post(
                          //   'http://$ip/auth/login',
                          //   options: Options(
                          //     headers: {
                          //       'Authorization': 'Basic $token',
                          //     },
                          //   ),
                          // );

                          // 데이터가 Map 형식으로 들어옴. (Json)
                          // final accessToken = resp.data['accessToken'];
                          // final refreshToken = resp.data['refreshToken'];

                          // final storage = ref.read(secureStorageProvider);

                          // await storage.write(
                          //     key: ACCESS_TOKEN_KEY, value: accessToken);
                          // await storage.write(
                          //     key: REFRESH_TOKEN_KEY, value: refreshToken);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => RootTab(),
                          //   ),
                          // );
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    backgroundColor: PRIMARY_COLOR,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('로그인'),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
