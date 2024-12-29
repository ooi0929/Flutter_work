import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/colors.dart';
import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../provider/pagination_provider.dart';
import '../utils/pagination_utils.dart';

// 함수 정의.
// Widget을 만들자.
// typedef를 선언을 하면, typedef에 해당하는 함수를 입력받겠다 할 수 있다.

// 함수를 받을건데
// context, index, model을 파라미터로 갖는 함수를 입력받을 것이다.
// 이때 model은 반드시 IModelWithId를 상속받는 타입이어야 한다.
typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

// listener를 쓰기 위해 StatefulWidget으로 생성
class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    super.key,
    required this.provider,
    required this.itemBuilder,
  });

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
    }

    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              backgroundColor: PRIMARY_COLOR,
              foregroundColor: Colors.white,
            ),
            child: Text('다시 시도'),
          ),
        ],
      );
    }

    final pState = state as CursorPagination<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // 새로고침
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(widget.provider.notifier).paginate(
                forceRefetch: true,
              );
        },
        color: PRIMARY_COLOR,
        backgroundColor: Colors.white,
        child: ListView.separated(
          // 리스트가 짧은 경우 스크롤이 안되게 되어있음.
          // 짧은 경우에도 스크롤이 가능하도록 하는 방법.
          physics: AlwaysScrollableScrollPhysics(),
          controller: controller,
          itemCount: pState.data.length + 1,
          itemBuilder: (context, index) {
            if (index == pState.data.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: pState is CursorPaginationFetchingMore
                      ? CircularProgressIndicator(color: Colors.blue)
                      : Text('데이터가 마지막 데이터입니다.'),
                ),
              );
            }

            final pItem = pState.data[index];

            // 여기가 중요
            // typedef를 만들어서 외부에서 제공해주는 함수를 만들 것.
            return widget.itemBuilder(context, index, pItem);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.0);
          },
        ),
      ),
    );
  }
}


