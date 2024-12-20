import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_workspace/codefactory_intermediate/state_management/riverpod/provider_observer.dart';

import 'screen/home_screen.dart';

class StateManagement extends StatelessWidget {
  const StateManagement({super.key});

  @override
  Widget build(BuildContext context) {
    // 프로바이더를 사용하려면 MaterialApp 위에 ProviderScope를 넣어줘야 한다.
    return ProviderScope(
      // ProviderScope를 관찰할 수 있는 기능 - observer를 상속하는 클래스를 만들고 observer에 추가해줘야한다.
      observers: [
        Logger(),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
