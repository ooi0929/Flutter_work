import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/pagination_list_view.dart';
import '../../restaurant/view/restaurant_detail_screen.dart';
import '../component/product_card.dart';
import '../model/product_model.dart';
import '../provider/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(
              RestaurantDetailScreen.routeName,
              pathParameters: {'rid': model.restaurant.id},
            );
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     // 20개의 레스토랑 데이터가 있는데 21개의 레스토랑 데이터를 조회하려니 에러가 발생
            //     // 메모리에 있지 않은 데이터를 가져올 땐 어떻게 캐시를 처리할까?
            //     // restaurant provider에서 로직 수정
            //     builder: (context) => RestaurantDetailScreen(
            //       id: model.restaurant.id,
            //     ),
            //   ),
            // );
          },
          child: ProductCard.fromProductModel(model: model),
        );
      },
    );
  }
}
