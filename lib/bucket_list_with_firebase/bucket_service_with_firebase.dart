import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BucketServiceWithFirebase extends ChangeNotifier {
  // bucket 컬렉션 인스턴스 생성
  final bucketCollection = FirebaseFirestore.instance.collection('bucket');

  // bucket 가져오기
  Future<QuerySnapshot> read(String uid) async {
    // 내 bucketList 가져오기
    // throw UnimplementedError(); // return 값 미구현 에러

    // uid와 일치하는 문서만 가져오도록 조건 설정
    // 컬렉션.get() -> Future<QuerySnapshot>을 반환
    return bucketCollection.where('uid', isEqualTo: uid).get();
  }

  // bucket 만들기
  void create(String job, String uid) async {
    await bucketCollection.add({
      'uid': uid, // 유저 식별자
      'job': job, // 하고싶은 일
      'isDone': false, // 완료 여부
    });

    notifyListeners(); // 화면 갱신
  }

  // bucket 업데이트
  void update(String docId, bool isDone) async {
    await bucketCollection.doc(docId).update({'isDone': isDone});
    notifyListeners();
  }

  // bucket 삭제
  void delete(String docId) async {
    await bucketCollection.doc(docId).delete();
    notifyListeners();
  }
}
