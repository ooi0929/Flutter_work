import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../const/project_list.dart';

// 프로젝트의 개수만큼 Route Menu 생성
class ProjectRouteMenu extends StatelessWidget {
  const ProjectRouteMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projectList.length,
      itemBuilder: (context, index) {
        // 각 항목에 대한 _routeMenu 호출
        return _routeMenu(context, index);
      },
    );
  }

  Widget _routeMenu(BuildContext context, int index) {
    // index에 맞는 프로젝트 이름과 아이콘을 가져온다.
    String projectName = projectList.keys.elementAt(index);
    IconData projectIcon = projectList[projectName]!;

    return ListTile(
      leading: Icon(
        projectIcon,
        color: Colors.grey[850],
      ),
      title: Text(projectName),
      subtitle: Text('#${index + 1}'),
      trailing: Icon(Icons.navigate_next),
      onTap: () => context.go('/$projectName'),
    );
  }
}
