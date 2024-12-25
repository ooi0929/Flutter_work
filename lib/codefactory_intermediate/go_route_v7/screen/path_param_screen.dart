import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

class PathParamScreen extends StatelessWidget {
  const PathParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          // Go Route의 상태를 가져올 땐
          // GoRouteState.of(context)이용
          //
          // path parameter를 가져오고 싶다면 pathParameters 속성을 이용해주면 된다.
          Text('Path Param: ${GoRouterState.of(context).pathParameters}'),

          CustomElevatedButton(
            onPressed: () {
              context.go('/path_param/456/codefactory');
            },
            data: 'Go One More',
          ),
        ],
      ),
    );
  }
}
