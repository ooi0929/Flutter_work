import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/provider/go_router.dart';

// 서버 실행 방법
// npm run start:dev
// localhost:3000/api/ or 127.0.0.1:3000/api/ -> swagger 페이지 나오는지 확인

// 서버에 등록된 사용자
// ID: test@codefactory.ai
// PW: testtest

// base64로 인코딩된 값
// dGVzdEBjb2RlZmFjdG9yeS5haTp0ZXN0dGVzdA==

// accessToken 유효기간: 5분

class Restaurant extends ConsumerWidget {
  const Restaurant({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
