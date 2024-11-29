import 'package:flutter/material.dart';

import '../component/project_route_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 제목
      appBar: AppBar(
        title: Text(
          'Homepage',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),

      // 프로젝트 목록 (Route)
      endDrawer: Drawer(
        child: ProjectRouteMenu(),
      ),

      // 설명
      body: Center(
        child: Text('우측 상단의 메뉴 바를 통해 원하는 프로젝트로 이동하세요.'),
      ),
    );
  }
}
