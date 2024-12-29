import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

///
/// {
///  "basket": [
///    {
///      PatchBasketBodyBasket
///    }
///  ]
/// }
///
///

@JsonSerializable()
class PatchBasketBody {
  final List<PatchBasketBodyBasket> basket;

  PatchBasketBody({required this.basket});

  Map<String, dynamic> toJson() => _$PatchBasketBodyToJson(this);
}

@JsonSerializable()
class PatchBasketBodyBasket {
  final String productId;
  final int count;

  PatchBasketBodyBasket({
    required this.productId,
    required this.count,
  });

  // .g. 파일에서 fromJson이 없어서 에러가 발생할경우
  // 그냥 생성해서 넣어주면 된다.
  factory PatchBasketBodyBasket.fromJson(Map<String, dynamic> json) =>
      _$PatchBasketBodyBasketFromJson(json);

  Map<String, dynamic> toJson() => _$PatchBasketBodyBasketToJson(this);
}
