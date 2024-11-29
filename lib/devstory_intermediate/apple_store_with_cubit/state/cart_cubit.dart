import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/product.dart';

class CartCubit extends Cubit<List<Product>> {
  // 여기서 상태 초깃값 생성
  CartCubit() : super([]);

  // 상품 클릭
  void onProductPressed(Product product) {
    if (state.contains(product)) {
      // state.remove(product);
      // emit(state);
      emit(state.where((e) => e != product).toList());
    } else {
      // state.add(product);
      // emit(state);
      emit([...state, product]);
    }
  }
}
