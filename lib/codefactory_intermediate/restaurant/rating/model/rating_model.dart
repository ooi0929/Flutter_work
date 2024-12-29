import 'package:json_annotation/json_annotation.dart';

import '../../common/model/model_with_id.dart';
import '../../common/utils/data_utils.dart';
import '../../user/model/user_model.dart';

part 'rating_model.g.dart';

// Repository 작성할 때
// 카테고리별로 나누기
// ex)
// /restaurant/ ~ 
// 내용들은 모두 restaurant에서 관리

@JsonSerializable()
class RatingModel implements IModelWithId {
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  // 기존 이미지들은 String으로 들어오기에 바로 JsonKey로 바꿧지만
  // List로 들어오는 순간 List로 들어오는 것에 맞춰서
  // Utils에 생성해줘야한다.
  @JsonKey(
    fromJson: DataUtils.listPathToUrls,
  )
  final List<String> imgUrls;

  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.imgUrls,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
