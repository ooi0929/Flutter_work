// import 'package:calculator/core/environment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../calculator/page/calculator.dart';
import '../homepage/page/home_page.dart';
import '../todo/page/todo.dart';

// Route 정보 설정
final _router = GoRouter(
  // 초기화면을 홈페이지 화면으로 설정
  initialLocation: '/',

  // 라우트 경로
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) => const Calculator(),
    ),
    GoRoute(
      path: '/todo',
      builder: (context, state) => const Todo(),
    ),
  ],
);

class HomepageApp extends StatelessWidget {
  const HomepageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // MaterialApp.router() -> home (x)
      // home: Environment.instance.buildType.build(context),
      routerConfig: _router, // 라우터 정보 등록
    );
  }
}
