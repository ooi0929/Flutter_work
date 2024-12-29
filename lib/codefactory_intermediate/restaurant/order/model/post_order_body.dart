import 'package:json_annotation/json_annotation.dart';

part 'post_order_body.g.dart';

@JsonSerializable()
class PostOrderBody {
  // 유니크한 값을 가질 것임.
  // 서버측에서 id 생성하는 작업을 주로 하지만
  // 프론트측에서 id 생성하는 작업이 더 유용할 때에도 있음.
  // 단, 프론트측에서 id를 생성할 때에는 무조건 글로벌하게 유니크해야한다.
  // 절대로 겹칠 수 없도록 해줘야 한다.
  // -> 데이터베이스에서 값이 중복되어 트랜잭션이 발생하게 되면 로직이 복잡해지기 때문에.

  // 이렇게 못할 경우 서버에서 생성을 하도록 해야한다.
  // 프론트에서 uuid를 생성하게 되면 99프로 겹치지않는 id를 생성할 수 있다.
  final String id;
  final List<PostOrderBodyProduct> products;
  final int totalPrice;
  // DateTime으로 받아도 괜찮음.
  // 어차피 안쓸거기 때문에 String으로 받을것임.
  final String createdAt;

  PostOrderBody({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.createdAt,
  });

  factory PostOrderBody.fromJson(Map<String, dynamic> json) =>
      _$PostOrderBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PostOrderBodyToJson(this);
}

@JsonSerializable()
class PostOrderBodyProduct {
  final String productId;
  final int count;

  PostOrderBodyProduct({
    required this.productId,
    required this.count,
  });

  factory PostOrderBodyProduct.fromJson(Map<String, dynamic> json) =>
      _$PostOrderBodyProductFromJson(json);

  Map<String, dynamic> toJson() => _$PostOrderBodyProductToJson(this);
}
