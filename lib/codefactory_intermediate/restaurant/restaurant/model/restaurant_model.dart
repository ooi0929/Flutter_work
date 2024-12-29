import 'package:json_annotation/json_annotation.dart';

import '../../common/model/model_with_id.dart';
import '../../common/utils/data_utils.dart';

part 'restaurant_model.g.dart';

// 데이터를 모델링 해야하는 이유
// 데이터를 Map형식으로 불러오는 것에서부터 문제가 생김.
// 데이터를 그냥 item['thumbUrl']과 같이 불러오게 되면
// 키 값에 오타가 발생해도 문제없이 코드가 진행된다.
// 따라서
// 클래스로 데이터를 모델링하는 작업이 필수!

// 모델링과 관련된 코드들은 model 파일을 따로 작성해서 관리
// + UI와 관련되어 작성되지 않기에 클래스로 작성됨.

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

// build_runner 사용법
// flutter pub run build_runner build - 일회성
// flutter pub run build_runner watch - 자동화

// Json Serializable 사용법
// 1. 자동으로 코드를 생성하고자 하는 클래스 위에 @JsonSerializable() 붙이기.
// 2. part 파일 생성 (현재파일이름.g.dart)

// 적용법
// factory 생성자를 똑같이 생성
// (fromJson 기준)
// factory 클래스이름.fromjson(Map<String, dynamic> json)
// => _$클래스이름FromJson(json)

// thumUrl처럼 작업이 필요할 때,
// .g. 파일은 건들면 안됨 (무조건!)
// 변경이 필요한 속성 위에 @JsonKey() 붙이기
// fromJson: fromJson이 실행이 됐을 때 실행하고 싶은 함수는 여기서 작성
// toJson: toJson이 실행이 됐을 때 실행하고 싶은 함수는 여기서 작성
// static 함수가 필요함!!
// 이름은 자유자재로 지으나 변경하고자 하는 속성값이 파라미터로 들어옴
@JsonSerializable()
class RestaurantModel implements IModelWithId {
  // 실제 API 요청값과 같이 클래스에 작성하였기 때문에
  // 오타걱정없이 값을 가져올 수 있다.
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  // 현재 인스턴스에서 다시 json으로 바꿀 때 사용하는
  // 이제는 json을 반환할거기 때문에 + Json으로 바꿀거기 때문에
  // _$클래스이름ToJson(현재 인스턴스)
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // 다른 파일에서도 공통적으로 상용되기에 utils 파일을 만들어서 그곳에서 관리
  // value - thumbUrl
  // static pathToUrl(String value) {
  //   return 'http://$ip$value';
  // }

  // json으로부터 데이터를 가져온다는 의미로
  // json은 항상 Map<String, dynamic> 형식으로 데이터가 들어온다.
  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json, // snapshot.data!
  // }) {
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     // item은 List<dynamic>을 반환하기에 에러
  //     // List<String>으로 타입을 변경하는 로직
  //     tags: List<String>.from(json['tags']),
  //     // 값을 하나씩 맵핑하면서 첫 번째 값을 찾는 것.
  //     priceRange: RestaurantPriceRange.values.firstWhere(
  //       (e) => e.name == json['priceRange'],
  //     ),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }

  // .fromJson마저 반복적이라고 느껴짐
  // 자동화할 방법이 없을까? -> Json serializable
}
