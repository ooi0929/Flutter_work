import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_utils.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

// 로딩 상태일 때
class UserModelLoading extends UserModelBase {}

// 에러 상태일 때
class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

// 로그인한 상태
// 로그인하지 않은 상태 -> null
// URL 부분은 항상 JSONKEY로 바꾸는 걸 잊지않기! (주의)
@JsonSerializable()
class UserModel extends UserModelBase {
  final String id;
  final String username;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imageUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
