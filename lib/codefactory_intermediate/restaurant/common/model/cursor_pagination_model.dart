import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// 상태를 클래스로 나눌 때 항상 base클래스를 만든다.
// abstract 클래스로 인스턴스화 못하게 생성 -> CorsorPagination에서 상속
// 이후 CorsorPagination 클래스가 CursorPaginationBase 타입인지 검사했을 때 참이 나오게 하는 것이 중요.
// ex) CorsorPagination is CursorPaginationBase = true.

// 근데 여기서는 JsonSerializable을 사용할 필요가 없다.
// 응답받은 json을 기반으로 인스턴스를 만들 것이 아니기 때문에
abstract class CursorPaginationBase {}

// 에러가 났을 때 상태
// CursorPaginationError 또한 CursorPaginationBase의 타입
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

// 로딩중일 때 상태
// 이때에도 값을 넣지 않아도 된다.
// data is CursorPaginationLoading = true라는 가정하에 우리는 현재 데이터가 로딩중이라는 것을 알 수 있음.
// 왜? 이 클래스의 인스턴스인지 아닌지만 체크하면 해당 클래스가 어떤 상태인지 알 수 있기 때문.
class CursorPaginationLoading extends CursorPaginationBase {}

// 데이터가 성공적으로 왔을 때 상태
// retrofit에는 Post 요청의 응답값과 데이터값이 완전히 동일한 데이터가 들어와야 하기 때문에.
// pagination을 따로 모델링하는 클래스를 작성한다.
@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  // 우리는 data부분이 RestaurantModel만 오는 것이 아니라
  // 상황에 따라 원하는 모델을 외부에서 받아왔으면 한다.
  // 왜? Swagger를 보면 pagination 부분에 meta데이터의 구조도 같고, data를 List형식으로 불러오는 부분도 같기에 모델 부분만 다르고 나머지는 동일한 값을 받기 때문에
  // final List<RestaurantModel> data;

  // 타입을 변수처럼 받는 방법
  // 제네릭을 이용.
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  // 제네릭을 이용하면 타입이 지정되어 있지 않기 때문에
  // json으로부터 어떤 클래스로 변환할지 모르기 때문에 에러가 발생한다.
  // -> 외부에서 어떻게 전환되는지를 알려주는 방법이 필요함.
  // T Function(Object? json) fromJsonT라는 매개변수를 추가해줘야함.
  // factory CursorPaginationModel.fromJson(Map<String, dynamic> json) =>
  //     _$CursorPaginationModelFromJson(json);
  // + @JsonSerializable()에 genericArgumentFactories: true를 추가해줘서
  // 코드를 생성할 때 제네릭 인자를 고려한 코드를 생성할 수 있다.
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  CursorPaginationMeta copyWith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPaginationMeta(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 새로고침 (데이터를 다시 불러오기)
// 앱에서 위로 쭉 당길 때 데이터를 다시 불러오는 기능 이럴 때 사용
// 이때에는 meta와 List data가 이미 존재한다는 가정이기 때문에
// CursorPagination을 상속받는다. -> CursorPaginationBase도 상속받고 있다.
// instance is CursorPagination
// instance is CursorPaginationBase 둘 다 true값.
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는 중일 때
// 왜 여기서는 로딩 클래스를 못 쓰냐? -> meta와 data가 없기 때문에.
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
