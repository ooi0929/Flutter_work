import 'package:flutter/cupertino.dart';

import '../const/bucket.dart';

// bucket 담당
class BucketService {
  // BucketService를 Singleton으로 확장.
  static final BucketService _instance = BucketService._internal();
  static BucketService get instance => _instance;

  // bucketList Notifier
  final ValueNotifier<List<Bucket>> _bucketList;
  ValueNotifier<List<Bucket>> get bucketList => _bucketList;

  // 외부에서 생성못하도록 생성자 생성
  BucketService._internal()
      : _bucketList = ValueNotifier<List<Bucket>>([Bucket('job', false)]);

  // 새로운 Bucket 생성
  void createBucket(String job) {
    var newBucket = Bucket(job, false);
    var newBucketList = List<Bucket>.from(_bucketList.value)..add(newBucket);

    _saveManager(newBucketList);
  }

  // Bucket 수정
  void updateBucket(int index) {
    bucketList.value[index].isDone = !bucketList.value[index].isDone;
    var newBucketList = List<Bucket>.from(_bucketList.value);
    _saveManager(newBucketList);
  }

  // Bucket 삭제
  void deleteBucket(int index) {
    _saveManager(List<Bucket>.from(_bucketList.value)..removeAt(index));
  }

  // BucketList 변경
  void _saveManager(List<Bucket> newBucketList) {
    _bucketList.value = newBucketList;
  }
}
