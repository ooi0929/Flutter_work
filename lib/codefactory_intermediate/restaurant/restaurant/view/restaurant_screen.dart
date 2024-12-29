import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/pagination_list_view.dart';
import '../component/restaurant_card.dart';
import '../provider/restaurant_provider.dart';
import 'restaurant_detail_screen.dart';

// Stateless -> Stateful로 바꾼 이유
// 스크롤을 내렸을 때 어느 포지션에 위치했는지 알기 위해서
// class RestaurantScreen extends ConsumerStatefulWidget {
//   const RestaurantScreen({super.key});

//   @override
//   ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
// }

// Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
//   final dio = ref.watch(dioProvider);

// dio.interceptors.add(
//   CustomInterceptor(
//     storage: storage,
//   ),
// );

// retrofit 사용전
// final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

// // 페이지네이션으로 아이템 가져오는 api요청
// final resp = await dio.get(
//   'http://$ip/restaurant',
//   options: Options(
//     headers: {
//       'Authorization': 'Bearer $accessToken',
//     },
//   ),
// );

// // data에 모든 오브젝트 데이터가 들어오기에 필요한 data키 값만 받아옴.
// return resp.data['data'];

// retrofit 사용후
// final resp =
//     await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
//         .paginate();

// return resp.data;
// }

// class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});
  // 스크롤의 포지션을 알기위해
  // final ScrollController controller = ScrollController();

  // @override
  // void initState() {
  //   super.initState();

  //   controller.addListener(scrollListener);
  // }

  // void scrollListener() {
  // 현재 위치가
  // 최대 길이보다 조금 덜되는 위치까지 왔다면
  // 새로운 데이터를 추가 요청
  // offset: 스크롤했을 때의 현재 위치를 가져올 수 있다.
  // position.maxScrollExtent: 최대 스크롤 가능한 길이
  // 300: px기준
  // 일반화 작업전
  // if (controller.offset > controller.position.maxScrollExtent - 300) {
  //   // 데이터를 더 가져오는 함수
  //   ref.read(restaurantProvider.notifier).paginate(
  //         fetchMore: true,
  //       );
  // }

  // 일반화 작업후
  //   PaginationUtils.paginate(
  //     controller: controller,
  //     provider: ref.read(restaurantProvider.notifier),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // pagination 일반화 작업후
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RetaurantModel>(_, index, model) {
        return GestureDetector(
          // GoRouter로 변경
          onTap: () {
            // context.go('/restaurant/${model.id}');
            // named router를 통해 더 쉽게
            // pathParameters에 Map형식으로
            // state.parameters['rid']가 우리가 입력한 rid가 된다.
            context.goNamed(
              RestaurantDetailScreen.routeName,
              pathParameters: {
                'rid': model.id,
              },
              // 쿼리 파라미터는 웹을 쓰지 않는 이상
              // 쓰지 않는게 좋다.
              // queryParameters: {

              // }
            );

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => RestaurantDetailScreen(
            //       id: model.id,
            //     ),
            //   ),
            // );
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );

    // provider를 등록해줌과 동시에 FutureBuilder가 필요가 없음.
    // 그럼 왜 캐싱이 되는거냐? -> autoDispose로 설정하지 않았기 때문에!
    // final data = ref.watch(restaurantProvider);

    // 우선은 잘못된 예외처리
    // OOP개념 도입전
    // if (data.length == 0) {
    //   return Center(
    //     child: CircularProgressIndicator(color: Colors.blue),
    //   );
    // }

    // OOP개념 도입후
    // 이때는 진짜 로딩일 때가 됨.
    // 완전 처음 로딩일 때
    // if (data is CursorPaginationLoading) {
    //   return Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.blue,
    //     ),
    //   );
    // }

    // 에러 상태일 때
    // if (data is CursorPaginationError) {
    //   return Center(
    //     child: Text(data.message),
    //   );
    // }

    // 나머지 3가지의 상태
    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    // 위에서 로딩 분기를 처리했기에 데이터 존재한다고 가정.
    // 실제로 이렇게 해서는 안된다.
    // cp = cursor pagination
    // 캐스팅작업
    // final cp = data as CursorPagination;

    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //   child: ListView.separated(
    //     controller: controller,
    // itemCount: cp.data.length,
    // item 가져올 때 마지막에 로딩창 띄우는 방법
    // itemCount: cp.data.length + 1,
    // itemBuilder: (context, index) {
    //   if (index == cp.data.length) {
    // 이렇게만 작성하면 로딩을 계속 보여준다.
    // return Center(
    //   child: CircularProgressIndicator(color: Colors.blue),
    // );
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //     child: Center(
    //       child: data is CursorPaginationFetchingMore
    //           ? CircularProgressIndicator(color: Colors.blue)
    //           : Text('데이터가 마지막 데이터입니다.'),
    //     ),
    //   );
    // }

    // final pItem = cp.data[index];

    //   return GestureDetector(
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => RestaurantDetailScreen(
    //             id: pItem.id,
    //           ),
    //         ),
    //       );
    //     },
    //     child: RestaurantCard.fromModel(
    //       model: pItem,
    //     ),
    //   );
    // },
    //     separatorBuilder: (context, index) {
    //       return SizedBox(height: 16.0);
    //     },
    //   ),
    // );

    // return Center(
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //     // List타입의 데이터를 미래에 가져올 것이라고 명시.
    //     // 미래의 값들을 렌더링해주는 위젯
    //     //  child: FutureBuilder<List>(
    //     // child: FutureBuilder<List<RestaurantModel>>(
    //     child: FutureBuilder<CursorPaginationModel<RestaurantModel>>(
    //       // 어떤 Future 타입의 데이터를 가져올지.
    //       // future: paginateRestaurant(ref),
    //       future: ref.watch(restaurantRepositoryProvider).paginate(),
    //       // 데이터를 가져올 때 시점에 따라 분기 작성
    //       builder: (context, snapshot) {
    //         // 데이터가 없으면
    //         if (!snapshot.hasData) {
    //           return Center(
    //             child: CircularProgressIndicator(
    //               color: Colors.blue,
    //             ),
    //           );
    //         }

    //         return ListView.separated(
    //           // 아이템의 개수
    //           // itemCount: snapshot.data!.length,
    //           itemCount: snapshot.data!.data.length,
    //           // index별로 아이템을 렌더링
    //           itemBuilder: (context, index) {
    //             // [1]
    //             // index에 해당되는 아이템을 저장할 변수
    //             // final pItem = snapshot.data![index];
    //             final pItem = snapshot.data!.data[index];

    //             // [2]
    //             // item을 파싱
    //             // parsed

    //             // 이 부분마저 클래스로 만들어서 관리하는 곳에 넣고 싶다.
    //             // 어떻게 넣지? -> factory 이용
    //             // final pItem = RestaurantModel(
    //             //   id: item['id'],
    //             //   name: item['name'],
    //             //   thumbUrl: 'http://$ip${item['thumbUrl']}',
    //             //   // item은 List<dynamic>을 반환하기에 에러
    //             //   // List<String>으로 타입을 변경하는 로직
    //             //   tags: List<String>.from(item['tags']),
    //             //   // 값을 하나씩 맵핑하면서 첫 번째 값을 찾는 것.
    //             //   priceRange: RestaurantPriceRange.values.firstWhere(
    //             //     (e) => e.name == item['priceRange'],
    //             //   ),
    //             //   ratings: item['ratings'],
    //             //   ratingsCount: item['ratingsCount'],
    //             //   deliveryTime: item['deliveryTime'],
    //             //   deliveryFee: item['deliveryFee'],
    //             // );

    //             // [3]
    //             // 이젠 모델링한 클래스에 item을 넣고
    //             // 팩토리 생성자를 통해 맵핑이 알아서 이루어져 파싱된 데이터를 가진 인스턴스가 생성
    //             // JsonSerializable 사용전
    //             // final pItem = RestaurantModel.fromJson(json: item);

    //             // JsonSerializable 사용후
    //             // retrofit 사용후
    //             // final pItem = RestaurantModel.fromJson();

    //             // return RestaurantCard(
    //             //   image: Image.network(
    //             //     pItem.thumbUrl,
    //             //     // 전체 크기가 들어오도록 하기 위해 cover 사용
    //             //     fit: BoxFit.cover,
    //             //   ),
    //             //   name: pItem.name,
    //             //   tags: pItem.tags,
    //             //   ratings: pItem.ratings,
    //             //   ratingsCount: pItem.ratingsCount,
    //             //   deliveryTime: pItem.deliveryTime,
    //             //   deliveryFee: pItem.deliveryFee,
    //             // );

    //             // factory 생성자를 통해
    //             // 모델링을 한다면 위의 코드도 아래 코드처럼 간결하게 작성이 가능하다.
    //             return GestureDetector(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => RestaurantDetailScreen(
    //                       // id: pItem.id,
    //                       id: pItem.id,
    //                     ),
    //                   ),
    //                 );
    //               },
    //               child: RestaurantCard.fromModel(
    //                 // model: pItem,
    //                 model: pItem,
    //               ),
    //             );
    //           },
    //           // 아이템 사이에 들어갈 렌더링
    //           separatorBuilder: (context, index) {
    //             return SizedBox(height: 16.0);
    //           },
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
