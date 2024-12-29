import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../model/pagination_params.dart';
import '../repository/base_pagination_repository.dart';

// setValue에는 하나의 값밖에 못 들어가므로 여러 값을 넣기 위해 클래스를 생성한다.
class _PaginationInfo {
  final int fetchCount;
  final bool fetchMore;
  final bool forceRefetch;

  _PaginationInfo({
    this.fetchCount = 20,
    this.fetchMore = false,
    this.forceRefetch = false,
  });
}

// 어디서든 CursorPaginationBase를 extends한 모든 기능을 반환받고 있기 때문에
// CursorPagination의 데이터가 어떤 타입이든 간에 일반화되어 사용이 가능하다.

// 결국 클래스를 일반화해놓았기 때문에 재활용이 가능하다.

// 차이점.
// RestaurantRepository -> RestaurantRatingRespository
// 하지만 paginate()를 그대로 가져다 쓰기에는 기분 나쁨 -> 중복 코드이니까.

// Paginate()를 일반화하는 작업을 하자 -> OOP개념 사용 Inheritance!!
// <> 제네릭 사용!!
class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  // repository의 에러가 사라짐.
  // repository -> IBasePaginationRepository를 implement하는 클래스들은 모두 paginate()가 존재함.
  // 따라서 repository가 무슨 타입인지는 몰라도
  // 무조건 IBasePaginationRepository와 관련이 있는 값이 들어오는 것을 알 수 있다.
  // final IBasePaginationRepository repository;
  // 일반화를 더 하기 위해서 U 제네릭을 추가
  // 그런데 정확히 어떤 타입인지 모르기에 에러가 발생한다. -> U를 extends하여 IBasePaginationRepository와 관련이 있는 타입이라고 지정해준다.
  // paginate()함수가 있다는 것을 알 수 있기에 에러가 발생하지 않음.
  // 왜 제네릭에서 implement가 아닌 extends를 사용한것인가?
  // dart에서는 제네릭 안에서 implement를 사용할 수 없기 때문에.
  final U repository;

  // Debounce
  // 함수를 실행하고 완료하기까지 특정 기간동안 함수가 실행되면 기존꺼를 취소하고 마지막 함수만 실행한다.

  // Throttle
  // 함수를 실행하고 완료하기까지 특정 기간동안 함수가 실행되면 기존꺼만 유지하고 새로운 함수의 실행을 취소한다.

  // API 요청 후 가져오는 동안
  // 가져와서 추가한 순간에 다시 한번 요청이 불러와지는 현상이 있다.

  // 불필요한 추가 요청이 생겨난다.
  // 이때 Throttle을 쓰게 되면 특정 기간이내에 중복으로 데이터가 요청되는 것을 막을 수 있다.
  // -> 데이터 손실 방지.

  // Debounce
  // 네트워크 요청이 여러 번 일어날 때 사용하면 좋음.
  // 여러 번 요청이 들어오지만 그때마다 서버에 요청을 날리면
  // 서버 트래픽이 낭비되기 때문이다.
  // ex) 음식 추가, 장바구니(Subtract, Add)

  // 여러 번 요청을 날리지만 결국에 들어가는 요청은 한번이길 바랄때
  // 단, 여러 번 요청을 날려도 한번만 요청 들어가는 것이 상관없는 경우에만 사용

  // Debounce_Throttle 패키지 이용해서 쉽게 구현
  final paginationThrottle = Throttle(
      // 얼마나 시간 간격을 둘 것인지
      Duration(seconds: 3),
      // 처음 어떤 값을 갖고서 실행할 함수를 실행할 것인지
      initialValue: _PaginationInfo(),
      // 함수에 넣어주는 값이 똑같으면 함수를 실행할 것인지
      checkEquality: false);

  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();

    // setValue가 실행되면
    // listen()가 실행된다.
    paginationThrottle.values.listen(
      // 맨 처음에는 initialValue가 들어가고
      // 이후의 값은 setValue에 들어간 값이 들어간다.
      (state) {
        _throttlePagination(state);
      },
    );
  }

  Future<void> paginate({
    // 가져올 데이터 양
    int fetchCount = 20,
    // 추가 데이터 가져오기
    bool fetchMore = false,
    // 강제 로딩
    bool forceRefetch = false,
  }) async {
    // paginationThrottle.setValue()를 사용하면
    // Throttle을 이용해서
    // 함수를 실행할 수 있다.
    paginationThrottle.setValue(
      _PaginationInfo(
        fetchCount: fetchCount,
        fetchMore: fetchMore,
        forceRefetch: forceRefetch,
      ),
    );

    // try {
    //   // 이 부분을 T를 넣지 않아도 된다.
    //   // meta가 중요하고 조건만 볼거기 때문에
    //   if (state is CursorPagination && !forceRefetch) {
    //     final pState = state as CursorPagination;

    //     if (!pState.meta.hasMore) {
    //       return;
    //     }
    //   }

    //   final isLoading = state is CursorPaginationLoading;
    //   final isRefetching = state is CursorPaginationRefetching;
    //   final isFetchingMore = state is CursorPaginationFetchingMore;

    //   if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
    //     return;
    //   }

    //   PaginationParams paginationParams = PaginationParams(count: fetchCount);

    //   if (fetchMore) {
    //     final pState = state as CursorPagination<T>;

    //     state = CursorPaginationFetchingMore<T>(
    //         meta: pState.meta, data: pState.data);

    //     // dynamic은 최소화하고
    //     // 정확한 값들을 넣어줘야하는 것이 나중에 도움이 많이 된다.
    //     // 모델도 일반화를 한 번 해야함.
    //     // T: Pagination에서 가져오는 값들의 실제 데이터 타입이 될 것임.

    //     // <T>이 지정된 순간
    //     // id값의 속성이 존재하는 것을 알 수 있음.
    //     paginationParams = paginationParams.copyWith(
    //       after: pState.data.last.id,
    //     );
    //   } else {
    //     if (state is CursorPagination && !forceRefetch) {
    //       final pState = state as CursorPagination<T>;

    //       state = CursorPaginationRefetching<T>(
    //           meta: pState.meta, data: pState.data);
    //     } else {
    //       state = CursorPaginationLoading();
    //     }
    //   }

    //   final resp = await repository.paginate(
    //     paginationParams: paginationParams,
    //   );

    //   if (state is CursorPaginationFetchingMore) {
    //     final pState = state as CursorPaginationFetchingMore<T>;

    //     state = resp.copyWith(data: [
    //       ...pState.data,
    //       ...resp.data,
    //     ]);
    //   } else {
    //     state = resp;
    //   }
    // } catch (e, stack) {
    //   print(e);
    //   print(stack);
    //   state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    // }
  }

  _throttlePagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;

    try {
      // 이 부분을 T를 넣지 않아도 된다.
      // meta가 중요하고 조건만 볼거기 때문에
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      PaginationParams paginationParams = PaginationParams(count: fetchCount);

      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore<T>(
            meta: pState.meta, data: pState.data);

        // dynamic은 최소화하고
        // 정확한 값들을 넣어줘야하는 것이 나중에 도움이 많이 된다.
        // 모델도 일반화를 한 번 해야함.
        // T: Pagination에서 가져오는 값들의 실제 데이터 타입이 될 것임.

        // <T>이 지정된 순간
        // id값의 속성이 존재하는 것을 알 수 있음.
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
              meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        state = resp.copyWith(data: [
          ...pState.data,
          ...resp.data,
        ]);
      } else {
        state = resp;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
