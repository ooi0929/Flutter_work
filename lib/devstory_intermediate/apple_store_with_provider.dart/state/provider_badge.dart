import 'package:flutter/material.dart';

import 'provider_cart.dart';

class ProviderBadge extends ChangeNotifier {
  ProviderBadge({
    required this.providerCart,
  }) {
    providerCart.addListener(providerCartListener);
  }

  int counter = 0;
  final ProviderCart providerCart;

  void providerCartListener() {
    counter = providerCart.cartProductList.length;
    notifyListeners();
  }

  @override
  void dispose() {
    providerCart.removeListener(providerCartListener);
    super.dispose();
  }
}
