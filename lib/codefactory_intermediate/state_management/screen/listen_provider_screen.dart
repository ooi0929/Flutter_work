import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';
import '../riverpod/listen_provider.dart';

// [7]

// 무언가 값이 변경이 됐는데 변경된 값에 따른 함수를 또 실행하고 싶을 때 listen 함수를 실행한다.

// Stateless Widget을 Provider로 사용하고 싶다면 ConsumerWidget으로 변경
// Stateful Widget을 Provider로 사용하고 싶다면 ConsumerStatefulWidget으로 변경하고 모든 State 부분을 ConsumerState로 변경

// ConsumerStatefulWidget은 기존과 다르게 build()내에 WidgetRef ref 파라미터를 받지 않아도된다.
// 클래스 내에서 ref를 글로벌하게 제공해준다.
class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({super.key});

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  // initState()내부에서도 ref를 그냥 쓰면 된다.
  // initState()에서는 어떤 경우에서도 watch()를 하면 안된다. UI를 그리는 곳이 아니고 단발적으로만 실행되기 때문에

  // listen() 값이 삭제가 될 때까지 값이 영구적으로 유지
  // 값을 삭제하고 싶다면? autoDispose를 활용
  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 10,
      vsync: this,
      initialIndex: ref.read(listenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    // listen 함수도 <> 타입에 맞게 설정해줘야 한다.

    // listen 함수는 두 가지의 파라미터를 받는다.
    // 1. 어떤 프로바이더를 등록할건지
    // 2. previous와 next를 파라미터로 갖는 함수

    // previous: 기존 상태
    // next: 변경이 될 다음 상태

    // listen을 하게되면
    // 등록한 provider의 값이 변경이 될 때마다
    // listen 내의 함수를 실행을 한다.

    // listen()은 중복으로 실행이 안되게끔 설계가 되어있기 때문에
    // listen()는 따로 dispose를 할 필요가 없다.
    ref.listen<int>(listenProvider, (previous, next) {
      if (previous != next) {
        controller.animateTo(next);
      }
    });

    return DefaultLayout(
      title: 'ListenProviderScreen',
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(index.toString()),
              CustomElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 10 ? 10 : state + 1);
                },
                child: Text('다음'),
              ),
              CustomElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 0 ? 0 : state - 1);
                },
                child: Text('뒤로'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
