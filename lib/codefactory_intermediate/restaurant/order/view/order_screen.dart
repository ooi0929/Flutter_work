import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/component/pagination_list_view.dart';
import '../../common/layout/default_layout.dart';
import '../component/order_card.dart';
import '../model/order_model.dart';
import '../provider/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: PaginationListView<OrderModel>(
        provider: orderProvider,
        itemBuilder: <OrderModel>(context, index, model) {
          return OrderCard.fromModel(
            model: model,
          );
        },
      ),
    );
  }
}
