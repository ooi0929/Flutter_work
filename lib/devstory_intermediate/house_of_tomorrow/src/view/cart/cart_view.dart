import 'package:flutter/material.dart';
import 'package:flutter_workspace/devstory_intermediate/house_of_tomorrow/src/service/theme_service.dart';
import 'package:provider/provider.dart';

import '../../../theme/component/button/button.dart';
import '../../../theme/component/pop_button.dart';
import '../../../theme/component/toast/toast.dart';
import '../../../util/helper/intl_helper.dart';
import '../../../util/lang/generated/l10n.dart';
import '../../service/cart_service.dart';
import 'widget/cart_bottom_sheet.dart';
import 'widget/cart_checkout_dialog.dart';
import 'widget/cart_delete_dialog.dart';
import 'widget/cart_empty.dart';
import 'widget/cart_item_tile.dart';
import 'widget/cart_layout.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartService cartService = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.cart),
        leading: const PopButton(),
        titleSpacing: 0,
        actions: [
          // Delete Button
          Button(
            onPressed: () {
              // Show delete dialog
              showDialog(
                context: context,
                builder: (context) {
                  return CartDeleteDialog(
                    onDeletePressed: () {
                      cartService.delete(cartService.selectedCartItemList);
                      Toast.show(S.current.deleteDialogSuccessToast);
                    },
                  );
                },
              );
            },
            text: S.current.delete,
            type: ButtonType.flat,
            color: context.color.secondary,
            isInactive: cartService.selectedCartItemList.isEmpty,
          ),
        ],
      ),
      body: CartLayout(
        // CartItemList
        cartItemList: cartService.cartItemList.isEmpty
            ? const CartEmpty()
            : ListView.builder(
                itemCount: cartService.cartItemList.length,
                itemBuilder: (context, index) {
                  final cartItem = cartService.cartItemList[index];
                  return CartItemTile(
                    cartItem: cartItem,
                    onPressed: () {
                      cartService.update(
                        index,
                        cartItem.copyWith(
                          isSelected: !cartItem.isSelected,
                        ),
                      );
                    },
                    onCountChanged: (count) {
                      cartService.update(
                        index,
                        cartItem.copyWith(
                          count: count,
                        ),
                      );
                    },
                  );
                },
              ),

        // CartBottomSheet
        cartBottomSheet: CartBottomSheet(
          totalPrice: cartService.selectedCartItemList.isEmpty
              ? '0'
              : IntlHelper.currency(
                  symbol:
                      cartService.selectedCartItemList.first.product.priceUnit,
                  number:
                      cartService.selectedCartItemList.fold(0, (prev, curr) {
                    return prev + curr.count * curr.product.price;
                  }),
                ),
          selectedCartItemList: cartService.selectedCartItemList,
          onCheckoutPressed: () {
            // Show checkout dialog
            showDialog(
              context: context,
              builder: (context) {
                return CartCheckoutDialog(
                  onCheckoutPressed: () {
                    cartService.delete(cartService.selectedCartItemList);
                    Toast.show(S.current.checkoutDialogSuccessToast);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
