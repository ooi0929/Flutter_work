// 캐싱 관련 데이터들은 모두 Provider에 저장.
// 그 중에서 캐싱 데이터를 관리하는 Provider는 모두 StateNotifierProvider로 관리할 것.

// 왜? 메서드와 같이 로직을 많이 작성해서 클래스 안에 넣기 위해서.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/provider/pagination_provider.dart';
import '../model/restaurant_model.dart';
import '../repository/restaurant_repository.dart';

// restaurantProvider에서 제공해주는 상태에 반응을 해서
// 상태안에서 데이터 값을 family값으로 가져온다.
final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  // 여기부터는 무조건 CursorPagination 상태
  // 첫 번째 값 가져오기 (리스트에서)
  // family id와 같은 List의 id값만 가져오기 (RestaurantModel)

  // 값이 존재하면 존재하는 값으로 반환하고
  // 값이 없으면 null 값을 반환하도록 하는 함수
  // package:collection/collection.dart -> firstWhereOrNull
  // return state.data.firstWhere((e) => e.id == id);
  return state.data.firstWhereOrNull((e) => e.id == id);

});

// 의존성관계가 딱맞아 떨어지도록 연습!
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

// 1. Repository 안에서의 API 요청과 관련 로직을 작성하고 데이터를 가져온다음.
// 2. 초기화 작업을 거쳐야한다.
// 3. 이후 값을 기억하면 UI에 반영

// List<RestaurantModel>이 아닌
// CursorPagination 타입을 넣고
// meta값에서의 hasMore값으로 값의 여부를 따진 후 가져와야 하는 로직을 짜야한다
// 그러면 CursorPagination을 생성자로 가져와야 하는데 이때 타입에 따른 값을 넣기 이전의 생성자를 넣어야 하는데 어케해?
// CursorPagination에 isLoading이란 속성을 추가해서 관리해? 그러면 null값이 추가되어야 하고 아예 다른 정의의 클래스가 생성되어버리는건데?
// 그러면 상태를 그냥 클래스로 나누어버리자!

// CursorPagination의 타입을 지정해주면 안된다.
// 지정해주면 해당 인스턴스의 상태만 관리가 되기 때문에

// 그러면 어떻게 해야하지? 클래스 상태를 나눴을 때 모두 CursorPaginationBase를 상속받았지?
// CursorPaginationBase로 타입을 지정해주면
// 해당 타입인 모든 클래스가 들어올 수 있다. -> CursorPaginationBase를 상속받은 모든 것은 해당 타입을 가지기 때문에 상태에 들어갈 수 있다.

// class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
// 제네릭과 inheritance를 사용후
// class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  // final RestaurantRepository repository;

  RestaurantStateNotifier({
    // required this.repository,
    required super.repository,
  });
  // : super(
  // 처음 pagination을 받으면 로딩상태여야 하니까
  // 초기화 작업으로 CursorPaginationLoading을 넣어준다.
  // CursorPaginationLoading(),
  // ) {
  // paginate();
  // }

  // paginate는 앱이 실행되면 바로 실행되어야 하기 때문에
  // 시작하자 실행할 수 있도록
  // 생성자 바디에 만들어 실행 시킬 수 있다.
  // Future<void> paginate({
  // 가져올 데이터 양
  // int fetchCount = 20,
  // 추가 데이터 가져오기
  // true - 추가로 데이터 가져오기
  // false - 새로고침 (데이터를 유지한 현재 상태에서 덮어씌우기)
  // bool fetchMore = false,
  // 강제로 다시 로딩
  // true - CursorPaginationLoading() 처음 로딩작업부터 다시 시작하도록
  //   bool forceRefetch = false,
  // }) async {
  //   try {
// resp가 이미 CursorPagination 클래스임. repository로 들어가서 해당 메서드의 타입을 확인해보자.
  // final resp = await repository.paginate();

  // state = resp;

  // 5가지 가능성
  // state의 상태
  // [상태가]
  // 1) CursorPagination - 정상적으로 데이터가 있는 상태
  // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음 - forceRefetch = true)
  // 3) CursorPaginationError - 에러가 있는 상태
  // 4) CursorPaginationRefetching - 첫 번째 페이지부터 다시 데이터를 가져올 때
  // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

  // 복잡한 로직을 작성을 할 때 -> 일단 바로 반환이 되는 경우의 수를 작성을 하는 것이 좋다.
  // 바로 반환하는 상황
  // [1] hasMore = false일 때 -> (기존 상태에서 이미 다음 데이터가 없다는 값을 들고 있다면 더이상 paginate()를 실행할 필요가 없음.)
  // hasMore이 false이려면 우리가 데이터를 이미 가져온상황이어야함
  // [2] 로딩중 - fetchMore = true 일 때 - 즉시 반환한다.
  //    - fetchMore가 아닐 때 - 새로고침의 의도가 있을 수 있다. (이때에는 반환하지 않는다.)

  // [1]
  // 값이 존재하거나 새로고침 상황이 아닐 때이고 강제로 새로고침의 의도가 없다면
  // if (state is CursorPagination && !forceRefetch) {
  // state는 반드시 CursorPagination 상태이어야 한다. (100프로 확신하고 있어야 as를 통해 타입을 명시)
  // final pState = state as CursorPagination;

  // 더이상 데이터가 없다면
  // paginate()를 실행하지 않고 반환해준다.
  //   if (!pState.meta.hasMore) {
  //     return;
  //   }
  // }

  // [2]
  // 현재 세가지의 로딩 상태가 있다
  // 값이 true이면 해당 상태일 때의 로딩중이다.
  // 1.
  // final isLoading = state is CursorPaginationLoading;
  // 2.
  // final isRefetching = state is CursorPaginationRefetching;
  // 3.
  // final isFetchingMore = state is CursorPaginationFetchingMore;

  // 우선, 조건은 fetchMore이 true이어야함.
  // 2번 반환 상황
  // if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
  // return;
  // }

  // 처음에는 after 쿼리파라미터를 넘겨주지 않아도 되지만
  // 두번째부터는 after 쿼리파라미터에 마지막 id값을 넘겨줘야한다.
  // PaginationParams 생성
  // PaginationParams paginationParams = PaginationParams(
  //   count: fetchCount,
  // );

  // fetchMore
  // 데이터를 추가로 더 가져오는 상황
  // if (fetchMore) {
  //   final pState = state as CursorPagination;

  //   state = CursorPaginationFetchingMore(
  //     meta: pState.meta,
  //     data: pState.data,
  //   );

  // fetchMore에서는 after를 넣어줘야 하는 상황임.
  // paginationParams = paginationParams.copyWith(
  // last 겟터를 통해 마지막 데이터를 가져오고
  // 해당 id의 값을 넣어주면 됨.
  // after: pState.data.last.id,
  // );
  // 데이터를 처음부터 가져오는 상황
  // } else {
  // 만약에 데이터가 있는 상황이라면
  // 기존 데이터를 보존한채로 Fetch(=api요청을 진행한다.)를 진행
  //   if (state is CursorPagination && !forceRefetch) {
  //     final pState = state as CursorPagination;

  //     state =
  //         CursorPaginationRefetching(meta: pState.meta, data: pState.data);
  //   } else {
  //     state = CursorPaginationLoading();
  //   }
  // }

  // final resp = await repository.paginate(
  // 쿼리로 추가로 넘겨줄 값
  // paginationParams: paginationParams,
  // );

  // if (state is CursorPaginationFetchingMore) {
  //   final pState = state as CursorPaginationFetchingMore;

  // meta는 그대로 놔두기
  // 최신 데이터를 유지.. count&hasMore의 값을 우리가 최신으로 알고 있어야 하니까
  // state = resp.copyWith(
  // 기존 있던 데이터에 최신 데이터 추가
  // 20개 - 40개 - 60개 -> 데이터를 점점 모아놔야함
  //     data: [
  //       // 기존 데이터
  //       ...pState.data,
  //       // 새로운 데이터
  //       ...resp.data,
  //     ],
  //   );
  // } else {
  // CursorPaginationLoading or CursorPaginationRefactingd 일 때,
  // state = resp;
  // }
  // } catch (e) {
  // state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
  // }
  // }

  // 상세 내용 캐시
  void getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await paginate();
    }

    // state가 CursorPagination이 아닐 때 그냥 리턴
    // 우리가 할 수 있는게 없음. 서버에서 에러 난거임
    if (state is! CursorPagination) {
      return;
    }

    // 위를 통과하면
    // 비로소 CursorPagination 상태
    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    // 데이터가 존재하면
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // id: 2인 친구를 Detail모델로 가져와라
    // getDetail(id: 2);
    // [RestaurantDetailModel(1), RestaurantDetailModel(2), RestaurantDetailModel(3)]

    // 데이터가 존재하지 않으면 -> 메모리에 데이터가 없을 때
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3)]
    // 요청 id: 10
    // list.where((e) => e.id == 10) 데이터 X
    // 데이터가 없을 때는 그냥 캐시의 끝에다가 데이터를 추가해버린다.
    // [RestaurantModel(1), RestaurantModel(2), RestaurantModel(3), RestaurantDetailModel(10)]
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? resp : e)
            .toList(),
      );
    }
  }
}
