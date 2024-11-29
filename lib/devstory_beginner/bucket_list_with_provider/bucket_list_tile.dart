import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bucket_service.dart';

class BucketListTile extends StatelessWidget {
  const BucketListTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    BucketService bucketService = context.read<BucketService>();
    Bucket bucket = bucketService.bucketList[index];

    return ListTile(
      // 버킷 리스트 할 일
      title: Text(
        bucket.job,
        style: TextStyle(
          fontSize: 24,
          color: bucket.isDone ? Colors.grey : Colors.black,
          decoration:
              bucket.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      // 삭제 아이콘 버튼
      trailing: IconButton(
        icon: Icon(CupertinoIcons.delete),
        onPressed: () {
          // 삭제 버튼 클릭시
          bucketService.deleteBucket(index);
        },
      ),
      onTap: () {
        // 아이템 클릭시
        bucket.isDone = !bucket.isDone;
        bucketService.updateBucket(bucket, index);
      },
    );
  }
}
