import 'package:flutter/material.dart';

import 'bucket_list_tile.dart';
import 'create_page.dart';

// 버킷 클래스
class Bucket {
  String job; // 할 일
  bool isDone; // 완료 여부

  Bucket(this.job, this.isDone); // 생성자
}

class BucketList extends StatelessWidget {
  BucketList({super.key});

  final bucketList = ValueNotifier<List<Bucket>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '버킷 리스트',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ValueListenableBuilder(
        // 버킷 리스트 Notifier 등록
        valueListenable: bucketList,
        builder: (context, bucketList, child) {
          return bucketList.isEmpty
              ? Center(child: Text('버킷 리스트를 작성해주세요.'))
              : ListView.builder(
                  itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
                  itemBuilder: (context, index) => BucketListTile(
                    index: index,
                    bucket: bucketList[index],
                    deleteBucket: deleteBucket,
                  ), // index에 해당하는 bucket 가져오기
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () async {
          // + 버튼 클릭시 버킷 생성 페이지로 이동
          String? job = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );

          if (job != null) {
            Bucket newBucket = Bucket(job, false);
            List<Bucket> newBucketList = List.from(bucketList.value)
              ..add(newBucket);

            bucketList.value = newBucketList;
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void deleteBucket(int index) {
    List<Bucket> newBucketList = List.from(bucketList.value)..removeAt(index);
    bucketList.value = newBucketList;
  }
}
