import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../common/repository/base_pagination_repository.dart';
import '../../rating/model/rating_model.dart';

part 'restaurant_rating_repository.g.dart';

// baseUrl에서 어떤 id값에 따른 url 요청인지 지정을 해주어야 하기 때문에 family로 받는다.
final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>(
  (ref, id) {
    final dio = ref.watch(dioProvider);

    return RestaurantRatingRepository(dio,
        baseUrl: 'http://$ip/restaurant/$id/rating');
  },
);

// http://ip/restaurant/:id/rating - baseUrl
@RestApi()
abstract class RestaurantRatingRepository implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
