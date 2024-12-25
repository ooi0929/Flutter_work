import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 탭을 누를 때마다
// 새로운 라우트로 이동할 수 있겠끔.
class NestedScreen extends StatelessWidget {
  final Widget child;

  const NestedScreen({
    super.key,
    required this.child,
  });

  int getIndex(BuildContext context) {
    if (GoRouterState.of(context).matchedLocation == '/nested/a') {
      return 0;
    } else if (GoRouterState.of(context).matchedLocation == '/nested/b') {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GoRouterState.of(context).matchedLocation),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        fixedColor: Colors.blue,
        currentIndex: getIndex(context),
        onTap: (index) {
          if (index == 0) {
            context.go('/nested/a');
          } else if (index == 1) {
            context.go('/nested/b');
          } else {
            context.go('/nested/c');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'person',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: 'notifications',
          ),
        ],
      ),
    );
  }
}
