class ShoppingItemModel {
  // 이름
  final String name;
  // 개수
  final int quantity;
  // 구매했는지
  final bool hasBought;
  // 매운지
  final bool isSpicy;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });

  // copyWith()처럼 클래스에도 같은 기능을 하는 메서드를 생성할 수 있음.
  // 널값으로 파라미터 받고 this 키워드를 이용하여
  // 입력된 값만 값이 바뀌고 입력되지 않은 값은 그대로 사용되게끔 변경이 가능하다.
  ShoppingItemModel copyWith({
    String? name,
    int? quantity,
    bool? hasBought,
    bool? isSpicy,
  }) {
    return ShoppingItemModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      hasBought: hasBought ?? this.hasBought,
      isSpicy: isSpicy ?? this.isSpicy,
    );
  }
}
