import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bucket_service_with_firebase.dart';

class FirebaseBucketListTile extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const FirebaseBucketListTile({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    String job = doc.get('job');
    bool isDone = doc.get('isDone');

    return Consumer<BucketServiceWithFirebase>(
        builder: (context, bucketService, _) {
      return ListTile(
        title: Text(
          job,
          style: TextStyle(
            fontSize: 24,
            color: isDone ? Colors.grey : Colors.black,
            decoration:
                isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        // 삭제 아이콘 버튼
        trailing: IconButton(
          icon: Icon(CupertinoIcons.delete),
          onPressed: () {
            // 삭제 버튼 클릭시
            bucketService.delete(doc.id);
          },
        ),
        onTap: () {
          // 아이템 클릭하여 isDone 업데이트
          bucketService.update(doc.id, !isDone);
        },
      );
    });
  }
}
