import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

// pagination의 마지막 id값을 넘겨주기 위해
// 파라미터 또한 클래스로 정의할 수 있다.

// 받아온 값 또한 JsonSerializable을 이용해 값들을 직접 넣을 거기 때문에
// toJson이 중요
@JsonSerializable()
class PaginationParams {
  final String? after;
  final int? count;

  const PaginationParams({
    this.after,
    this.count,
  });

  // 값을 유지하면서 데이터를 바꾸고 싶은 상황이 있을 수 있기 때문에 copyWith() 정의
  PaginationParams copyWith({
    String? after,
    int? count,
  }) {
    return PaginationParams(
      after: after ?? this.after,
      count: count ?? this.count,
    );
  }

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}
