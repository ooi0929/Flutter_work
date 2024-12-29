import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/colors.dart';
import '../../restaurant/model/restaurant_detail_model.dart';
import '../../user/provider/basket_provider.dart';
import '../model/product_model.dart';

class ProductCard extends ConsumerWidget {
  final String id;

  final Image image;
  final String name;
  final String detail;
  final int price;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;

  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    this.onSubtract,
    this.onAdd,
  });

  factory ProductCard.fromProductModel({
    required ProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(8.0), child: image),
              // 이미지 이후에는 글자들만 넣을 거니까
              // Expanded를 사용해서 모든 공간을 차지
              // 다만 자식 위젯의 크기만큼만 공간을 차지하고 있기 때문에
              // IntrinsicHeight 위젯을 사용하면
              // 내부에 존재하는 모든 위젯들이 최대 크기를 차지하는 위젯의 크기에 맞춰서 크기를 차지하게 된다.
              // IntrinsicWidth는 반대로 생각하면 된다.
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      detail,
                      // 글자가 밖으로 나갔을 때 처리하는 방법
                      // clip: 자름.
                      // fade: 흐릿하게 처리
                      // visible: 넘어간 것을 보이게 함
                      // ellipsis: ...으로 보이게함
                      overflow: TextOverflow.ellipsis,
                      // 글자의 최대 라인 수
                      maxLines: 2,
                      style: TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₩$price',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (onSubtract != null && onAdd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _Footer(
              // 상태관리를 통해서 복잡함을 감수해야할 필요가 있다면
              // 내부에서 watch를 하는 것이고
              // 아니라면
              // 외부에서 주입을 받으면 된다.

              // 현재 상품이 존재한다는 가정으로 출발
              // 상품이 존재한다면 id값을 가지고 있어야 한다.
              total: (basket.firstWhere((e) => e.product.id == id).count *
                      basket
                          .firstWhere((e) => e.product.id == id)
                          .product
                          .price)
                  .toString(),
              count: basket.firstWhere((e) => e.product.id == id).count,
              onSubtract: onSubtract!,
              onAdd: onAdd!,
            ),
          ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer({
    required this.total,
    required this.count,
    required this.onSubtract,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액 ₩$total',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        renderButton(
          icon: Icons.remove,
          onTap: onSubtract,
        ),
        SizedBox(width: 8.0),
        Text(
          count.toString(),
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8.0),
        renderButton(
          icon: Icons.add,
          onTap: onAdd,
        ),
      ],
    );
  }

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          )),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
