import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/product.dart';

// 부모 이벤트 클래스를 만들고, 하위 이벤트들은 이를 상속받아 구현
@immutable
abstract class CartEvent {
  const CartEvent();
}

class OnProductPressed extends CartEvent {
  final Product product;

  const OnProductPressed(this.product);
}

// Bloc<이벤트 타입, 상태 타입>을 상속
class CartBloc extends Bloc<CartEvent, List<Product>> {
  CartBloc() : super([]) {
    on<OnProductPressed>((event, emit) {
      if (state.contains(event.product)) {
        // state.remove(event.product);
        // emit(state);
        emit(state.where((p) => p != event.product).toList());
      } else {
        // state.add(event.product);
        // emit(state);
        emit([...state, event.product]);
      }
    });
  }
}
