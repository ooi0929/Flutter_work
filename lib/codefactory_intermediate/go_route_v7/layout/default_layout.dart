import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  const DefaultLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // GoRouter에 등록된 path 가져오는 방법
        // GoRouteState를 사용한다.
        // .of(context) 사용 - Navigator.of(context)와 같음.
        // 실제 위젯트리의 위로 올라가서 위치 정보를 가져오는 것.
        title: Text(GoRouterState.of(context).matchedLocation),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: body,
      ),
    );
  }
}
