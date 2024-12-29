// dart언어에서는 interface가 따로 키워드가 존재하지 않는다.
// 클래스를 생성해서 사용해야 한다.

// dart 3.0 기준으로 이후부터는 interface가 존재함.
// 어떤 interface로 일반화를 만들거냐?
// restaurant의 repository를 확인해보면
// 각기 타입만 다른 같은 paginate() 기능이 존재하는 것을 볼 수 있다.

// abstract 키워드로 클래스를 정의하면
// body를 정의하지 않아도 된다.

// Interface라는 의미의 I를 붙임.

import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../model/pagination_params.dart';

// T를 IModelWithId로 강제함으로써
// CursorPaignation에 들어가는 제네릭 T는 무조건 id가 존재하는 데이터 타입이라는 것을 알 수 있음.
abstract class IBasePaginationRepository<T extends IModelWithId> {
  // paginate() 함수를 반드시 정의해야함.
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
