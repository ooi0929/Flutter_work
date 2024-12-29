// id값도 존재한다는 것을 알릴 수 있도록 일반화
// 일반화한 파일이기에 common 폴더에서 관리

// IModelWithId를 구현하는 모든 모델들은
// id 값을 무조건 들고 있도록 강제할 것임.
abstract class IModelWithId {
  final String id;

  IModelWithId({
    required this.id,
  });
}
