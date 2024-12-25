import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

class QueryParameterScreen extends StatelessWidget {
  const QueryParameterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text('Query Parameter: ${GoRouterState.of(context).uri}'),
          CustomElevatedButton(
            // /query_parameter?utm=google&source=123
            // ?를 기준으로 오른쪽 값은 path가 아닌 추가로 전달하는 정보를 뜻한다. (각종 데이터)
            onPressed: () {
              // push / go 둘다 사용가능
              context.push(
                // Uri: 기본 path를 넣을 수 있고,
                // queryparameter 속성이 있는데, String타입의 맵을 넣을 수 있음.

                // push할 때에는 String값을 넣어야 하므로 toString() 사용
                // /query_param?name=codefactory&age=32
                Uri(
                  path: '/query_param',
                  queryParameters: {
                    'name': 'codefactory',
                    'age': '32',
                  },
                ).toString(),
              );
            },
            data: 'Query Parameter',
          ),
        ],
      ),
    );
  }
}
