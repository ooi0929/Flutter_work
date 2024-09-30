import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workspace/bucket_list/service/bucket_service.dart';

class BucketListTile extends StatelessWidget {
  const BucketListTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 버킷 리스트 할 일
      title: Text(
        BucketService.instance.bucketList.value[index].job,
        style: TextStyle(
          fontSize: 24.0,
          decoration: BucketService.instance.bucketList.value[index].isDone
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          // 버튼 클릭시
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('정말로 삭제하시겠습니까?'),
                actionsPadding: EdgeInsets.all(0),
                actions: [
                  // 취소 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  // 확인 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      BucketService.instance.deleteBucket(index);
                    },
                    child: Text(
                      '확인',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(
          CupertinoIcons.delete,
        ),
      ),
      onTap: () {
        // 아이템 클릭시
        BucketService.instance.updateBucket(index);
      },
    );
  }
}
