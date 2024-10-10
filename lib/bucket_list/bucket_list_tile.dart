import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bucket_list.dart';

class BucketListTile extends StatelessWidget {
  const BucketListTile({
    super.key,
    required this.index,
    required this.bucket,
    required this.deleteBucket,
  });

  final int index;
  final Bucket bucket;
  final Function deleteBucket;

  @override
  Widget build(BuildContext context) {
    final isDone = ValueNotifier<bool>(bucket.isDone);

    return ListTile(
      // 버킷 리스트 할 일
      title: ValueListenableBuilder(
        valueListenable: isDone,
        builder: (context, isDone, _) {
          return Text(
            bucket.job,
            style: TextStyle(
              fontSize: 24,
              color: isDone ? Colors.grey : Colors.black,
              decoration:
                  isDone ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          );
        },
      ),
      // 삭제 아이콘 버튼
      trailing: IconButton(
        icon: Icon(CupertinoIcons.delete),
        onPressed: () {
          // 삭제 버튼 클릭시
          showDeleteDialog(context, index);
        },
      ),
      onTap: () {
        // 아이템 클릭시
        isDone.value = !isDone.value;
      },
    );
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("정말로 삭제하시겠습니까?"),
          actionsPadding: EdgeInsets.all(0),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                // index에 해당하는 항목 삭제
                deleteBucket(index);
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}
