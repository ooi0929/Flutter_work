import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/component/cart_button.dart';
import '../../../theme/component/color_picket.dart';
import '../../../theme/component/pop_button.dart';
import '../../../util/lang/generated/l10n.dart';
import '../../model/product.dart';
import '../base_view.dart';
import 'product_view_model.dart';
import 'widget/product_bottom_sheet.dart';
import 'widget/product_color_preview.dart';
import 'widget/product_desc.dart';
import 'widget/product_layout.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: ProductViewModel(
        product: product,
        cartService: context.read(),
      ),
      builder: (context, viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(S.current.product),
          leading: const PopButton(),
          titleSpacing: 0,
          actions: const [
            // 카트 버튼
            CartButton(),
          ],
        ),
        body: ProductLayout(
          productInfo: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Wrap(
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: [
                // ProductColorPreview
                ProductColorPreview(
                  colorIndex: viewModel.colorIndex,
                  product: product,
                ),

                // ColorPicker
                ColorPicker(
                  colorIndex: viewModel.colorIndex,
                  colorList: product.productColorList.map((e) {
                    return e.color;
                  }).toList(),
                  onColorSelected: viewModel.onColorIndexChanged,
                ),

                // ProductDesc
                ProductDesc(product: product),
              ],
            ),
          ),

          // ProductBottomSheet
          productBottomSheet: ProductBottomSheet(
            count: viewModel.count,
            product: product,
            onCountChanged: viewModel.onCountChanged,
            onAddToCartPressed: viewModel.onAddToCartPressed,
          ),
        ),
      ),
    );
  }
}
