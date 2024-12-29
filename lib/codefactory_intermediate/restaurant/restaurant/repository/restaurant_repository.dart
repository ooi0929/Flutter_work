import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../common/repository/base_pagination_repository.dart';
import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  // watch를 하는 이유
  // 만약 dioProvider에서 dio가 변경이 됐다면
  // 상태 변화를 알려줘야 하기 때문에
  // Provider안에서는 왠만해서는 watch를 쓰는게 좋다.
  final dio = ref.watch(dioProvider);

  // UI에는 무조건 UI관련된 코드만 있으면 베스트!
  final repository =
      RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

  return repository;
});

// 요청은 모두 repository에 모아두기.

// retrofit 사용법
// 1. RestApi() 애노테이션 사용
// 2. 코드 생성할거기 때문에 part 파일 생성
// 3. 인스턴스화가 안되도록 abstract 클래스로 생성
// 4. factory 생성자 생성
//
// (파라미터: dio - 외부에서 주입) 여러 파일에서 같은 인스턴스의 dio를 사용하기 위해
// (파라미터: baseUrl) 공통이 되는 url을 넣기위해

// factory 생성자는 =을 통해서 함수 바디를 지정할 수 있다.
// = _파일명

// 위의 패턴 유지

// 요청 함수 작성
// @요청메서드(baseUrl + path)
// abstract이기 때문에 어떤 함수들이 있어야 하는지만 정의
// 단, 어떤 값이 들어가야하는지와 어떤 값이 반환되어야 하는지를 입력해줘야 함.
// retrofit은 실제로 응답을 받는 형태와 완전히 똑같은 형태의 클래스를 반환값으로 넣어줘야함. -> 자동으로 json값이 맵핑되어 클래스의 인스턴스가 됨.
// api 요청이기에 Future를 반드시 명시해줘야 한다.
// 반환값: 어떤 모델로 맵핑이 되어야하는지
@RestApi()
// paginate() 일반화부터는 implement 사용
// 뭐가 좋냐?
// 타입을 지정할 수 있고, 해당 paginate() 기능을 구현해야 한다는 것을 dart sdk 내에서 알 수 있다.
abstract class RestaurantRepository implements IBasePaginationRepository<RestaurantModel> {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // pagenation API 요청
  // 일반화하기 위해 paginate()로 작성
  // http://$ip/restaurant/ - 끝에 / 붙고 안붙고는 상관없음
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  // Future<CursorPagination<RestaurantModel>> paginate();
  // 이제는 클래스를 파라미터로 정의할 수 있음.
  Future<CursorPagination<RestaurantModel>> paginate({
    // 커서의 다음값부터 가져올거니까
    // null형태이어도 되어야 한다.

    // 빌드타임 생성자 +
    // 안들어가도 되는 형태면 PaginationParams를 그대로 넣기

    // 그럼이제 API 요청을 보낼 때 Retrofit에서 쿼리파라미터를 넣는 것을 어떻게 하냐?
    // @Queries()를 사용
    // paginationParams에 해당하는 클래스가 쿼리값들로 변경이 된다.
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // API 메서드 요청에 따른 무슨 요청인지
  // ex) post요청이름()
  // http://$ip/restaurant/:id

  // {id}는 매번 다른 id값을 넣어줘야 하기 때문에
  // @Path()를 이용해서 대체가 가능하다.
  // 보통 파라미터의 id는 매개변수로 입력한 변수와 똑같은 이름으로 대체가 되고,
  // 매개변수의 이름이 다르다면,
  // @Path('id')와 같이 어떤 변수로 대체할지를 지정해줄 수 있다.
  // ex) Path('id') required String sid -> sid라 적고서 실제로 맵핑은 id랑 되도록 지정.

  // header를 추가하는 방법
  // @Headers() 애노테이션 사용
  // 단, dio랑 retrofit 둘 다 Headers를 갖고 있기 때문에 dio에 hide 키워드로 Headers를 가져오는것을 없앤다.
  @GET('/{id}')
  @Headers({
    // 'Authorization': 'Bearer 토큰',
    // interceptor에서 header값을 가져와 토큰을 관리.
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
