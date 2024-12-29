import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/utils/pagination_utils.dart';
import '../../product/component/product_card.dart';
import '../../product/model/product_model.dart';
import '../../rating/component/rating_card.dart';
import '../../rating/model/rating_model.dart';
import '../../user/provider/basket_provider.dart';
import '../component/restaurant_card.dart';
import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';
import '../provider/restaurant_provider.dart';
import '../provider/restaurant_rating_provider.dart';
import 'basket_screen.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';

  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

// 보면 우리는 Future함수를 통해 API 요청을 해서
// 데이터를 반환받고 그 값을 모델링한 클래스에 넣어줘서 파싱하는 작업을 하고 있음.

// 이 마저도 반복적이다고 생각하고 있음.
// API 요청부터 모델로 만드는 과정을 모두 자동화 해버리자!
//
// retrofit이 등장!

// 여태 작성한 과정들을 보면
// 요청하는 방법, 요청하는 url, 반환받는 값, 모델 변경
// 을 제외하고 과정은 동일하다.

// api 요청에 대한 데이터를 담을 곳.
// repository 폴더에서 다루기 다만, 실제 아키텍처에서 다루는 레포지토리 개념에 조금은 부족하다는 것만 인식

// Future<Map<String, dynamic>> getRestaurantDetail() async {
// 프로바이더를 통해 하나의 dio를 가져올 수 있음.
// WidgetRef ref를 통해서!!
// Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
// final dio = ref.watch(dioProvider);

// 프로바이더를 통해서 dio를 가져왔기에 이미 인터셉터가 적용된 dio를 사용하게 되어있음.
// 인터셉터 추가
// dio.interceptors.add(
//   CustomInterceptor(
//     storage: storage,
//   ),
// );

// retrofit 사용전
// final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

// final resp = await dio.get(
//   'http://$ip/restaurant/$id',
//   options: Options(
//     headers: {
//       'Authorization': 'Bearer $accessToken',
//     },
//   ),
// );

// return resp.data;

// retrofit 사용후
// final repository =
//     RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

//   return ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id);
// }

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // 들어올 때마다 id값에 맞는 상세정보를 불러옴.
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);

    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantRatingProvider(widget.id).notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // /basket 상단에 route가 존재하지 않기 때문에
          // 뒤로가기가 없어짐.

          // 이럴 때 push를 사용한다.
          context.pushNamed(BasketScreen.routeName);
        },
        backgroundColor: PRIMARY_COLOR,
        shape: CircleBorder(),
        child: Badge(
          // 배경색
          badgeStyle: BadgeStyle(
            badgeColor: Colors.white,
          ),
          // 언제 보여줄지
          showBadge: basket.isNotEmpty,
          // 어떤 값을 넣어줄 것인지
          badgeContent: Text(
            basket
                .fold<int>(
                  // 시작값
                  0,
                  // 기존값, 다음값
                  (previousValue, next) => previousValue + next.count,
                )
                .toString(),
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 10.0,
            ),
          ),
          child: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
          ),
        ),
      ),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          renderTop(
            model: state,
          ),
          // Skeleton 사용후
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              restaurant: state,
              products: state.products,
            ),

          // // 이젠 rating 시작
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   sliver: SliverToBoxAdapter(
          //     child: RatingCard(
          //       avatarImage: AssetImage(
          //         'assets/img/logo/codefactory_logo.png',
          //       ),
          //       images: [],
          //       rating: 4,
          //       email: 'jc@codefactory.ai',
          //       content: '맛있습니다.',
          //     ),
          //   ),
          // ),

          if (ratingsState is CursorPagination<RatingModel>)
            renderRatings(models: ratingsState.data)
        ],
      ),

      // FutureBuilder와 StreamBuilder의 특징
      // 데이터를 요청한 이력이 있다면 데이터가 기억이 되어있다. (캐싱)
      // 만약 데이터가 존재한다면 기억한 빌더를 끌어오고
      // 데이터가 변경이 된다면 로딩을 거쳐 새로운 빌더로 끌어온다.
      // 단점. 마음대로 어디서든 이 캐싱데이터를 가져오는 것이 불가능하다. -> riverpod을 사용해 캐싱을 만드는 것으로 해결
      // child: FutureBuilder<Map<String, dynamic>>(
      // child: FutureBuilder<RestaurantDetailModel>(
      // future: getRestaurantDetail(ref),
      // future: ref
      // .watch(restaurantRepositoryProvider)
      // .getRestaurantDetail(id: id),
      // builder: (context, snapshot) {
      // if (snapshot.hasError) {
      //   return Center(
      //     child: Text(snapshot.error.toString()),
      //   );
      // }

      // if (!snapshot.hasData) {
      //   return Center(
      //     child: CircularProgressIndicator(
      //       color: Colors.blue,
      //     ),
      //   );
      // }

      // JsonSerializable 사용전
      // final item = RestaurantDetailModel.fromJson(
      //   json: snapshot.data!,
      // );

      // JsonSerializable 사용후
      // final item = RestaurantDetailModel.fromJson(snapshot.data!);

      // 계속 스크롤하면 평점이 나오게 할 것임.
      // 평점은 다른 API 요청을 통해 처리함.
      // List 2개가 공존하지만 하나의 스크롤로 처리하도록 하기 위해 커스텀 스크롤뷰를 사용할 것임. (sliver - 최적화 빌더)

      // CustomScrollView에는 반드시 sliver가 필요.
      // sliver에는 일반 위젯과 sliver를 넣을 수 있는데
      // 일반 위젯을 넣으려면 SliverToBoxAdaptor()를 넣어야 한다.
      //   return CustomScrollView(
      //     slivers: [
      //       renderTop(
      //         // model: item,
      //         model: snapshot.data!,
      //       ),
      //       renderLabel(),
      //       renderProducts(
      //         // products: item.products,
      //         products: snapshot.data!.products,
      //       ),
      //     ],
      //   );
      // }),
    );
  }

  SliverToBoxAdapter renderTop({
    // required RestaurantDetailModel model,
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
    // RestaurantModel 추가 - InkWell에서 addToBasket에 사용하기 위해
    required RestaurantModel restaurant,
    required List<RestaurantProductModel> products,
  }) {
    // SliverPadding은 Sliver인데 Padding을 넣을 수 있는 것이다.
    // child대신 sliver 속성을 사용하면 된다.
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: products.length,
          (context, index) {
            final model = products[index];

            // InkWell 위젯
            // 눌럿을 때의 효과를 추가할 수 있음.
            // 눌럿을 때 화면 안에 그대로 있는 경우에는 InkWell 위젯을 자주 사용한다.
            // 눌럿을 때 다른 화면으로 전환될 때에는 필요가 없다.

            // GestureDetector은 눌럿을 때 무슨 상황인지는 알 수 없으나
            // 실행은 되고 있다.
            return InkWell(
              onTap: () {
                ref.read(basketProvider.notifier).addToBasket(
                      product: ProductModel(
                        id: model.id,
                        name: model.name,
                        detail: model.detail,
                        imgUrl: model.imgUrl,
                        price: model.price,
                        restaurant: restaurant,
                      ),
                    );

                // badges 패키지를 추가
                // 특정 UI 위젯에다가 숫자를 달 수 있는 기능을 주는 패키지이다.
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ProductCard.fromRestaurantProductModel(
                  model: model,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Skeleton 사용후
  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        // 반짝이 3개정도..?
        // Skeleton 패키지에 있는 이름 그대로 따오면 됨.
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  // 라인수
                  lines: 5,
                  // 자체 패딩 없애기
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RatingCard.fromModel(
              model: models[index],
            ),
          ),
          childCount: models.length,
        ),
      ),
    );
  }
}
