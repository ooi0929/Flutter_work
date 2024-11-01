import 'package:flutter/material.dart';

import '../../model/product.dart';
import '../../repository/product_repository.dart';
import '../base_view_model.dart';

class ShoppingViewModel extends BaseViewModel {
  ShoppingViewModel({
    required this.productRepository,
  });

  List<Product> productList = [];
  final TextEditingController textController = TextEditingController();
  final ProductRepository productRepository;

  String get keyword => textController.text.trim();

  Future<void> searchProductList() async {
    isBusy = true;
    final results = await Future.wait([
      productRepository.searchProductList(keyword),
      Future.delayed(const Duration(milliseconds: 555)),
    ]);
    productList = results[0];
    isBusy = false;
  }
}
