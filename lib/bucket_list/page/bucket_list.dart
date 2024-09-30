// Singleton 개념을 사용해서 Provider가 아닌 새롭게 상태관리하기.

import 'package:flutter/material.dart';
import 'package:flutter_workspace/bucket_list/service/bucket_service.dart';

import '../component/bucket_list_tile.dart';
import 'create_page.dart';

class BucketList extends StatelessWidget {
  const BucketList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '버킷 리스트',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ValueListenableBuilder(
        valueListenable: BucketService.instance.bucketList,
        builder: (context, list, _) {
          return ListView.builder(
            itemCount:
                BucketService.instance.bucketList.value.length, // 버킷 리스트의 개수
            itemBuilder: (context, index) {
              return BucketListTile(
                index: index,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () async {
          String? job = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePage(),
            ),
          );

          if (job != null) {
            BucketService.instance.createBucket(job);
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
