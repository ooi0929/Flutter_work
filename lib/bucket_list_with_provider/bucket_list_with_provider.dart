import 'package:flutter/material.dart';
import 'package:flutter_workspace/bucket_list_with_provider/bucket_list_tile.dart';
import 'package:provider/provider.dart';

import 'bucket_service.dart';
import 'create_page.dart';

class BucketListWithProvider extends StatelessWidget {
  const BucketListWithProvider({super.key});

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
      body: Consumer<BucketService>(
        builder: (context, value, child) {
          // BucketService의 bucketList 가져오기
          List<Bucket> bucketList = value.bucketList;

          return bucketList.isEmpty
              ? Center(child: Text('버킷 리스트를 작성해주세요'))
              : ListView.builder(
                  itemCount: bucketList.length,
                  itemBuilder: (context, index) => BucketListTile(index: index),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () {
          // + 버튼 클릭시 버킷 생성 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
