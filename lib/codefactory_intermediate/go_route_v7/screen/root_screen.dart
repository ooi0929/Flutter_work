import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          CustomElevatedButton(
            onPressed: () {
              // go 패키지를 불러와야만 context에 go라는 함수가 extension된다.
              // 해당 path로 이동하는 방법
              context.go('/basic');
            },
            data: 'Go Basic',
          ),
          CustomElevatedButton(
            onPressed: () {
              // path를 넣는 것이 아닌
              // name 속성에 지정해놓은 값을 넣으면 됨.
              context.goNamed('named_screen');
            },
            data: 'Go Named',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/push');
            },
            data: 'Go Push',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/pop');
            },
            data: 'Go Pop',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/path_param/456');
            },
            data: 'Go Path Param',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/query_param');
            },
            data: 'Go Query Parameter',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/nested/a');
            },
            data: 'Go Nested',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            data: 'Login Screen',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/login2');
            },
            data: 'Login2 Screen',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/transition');
            },
            data: 'Transition Screen',
          ),
          CustomElevatedButton(
            onPressed: () {
              context.go('/error');
            },
            data: 'Error Screen',
          ),
        ],
      ),
    );
  }
}
