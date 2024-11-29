import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'bucket_service_with_firebase.dart';
import 'firebase_bucket_list_tile.dart';
import 'login_page.dart';

class BucketListWithFirebase extends StatelessWidget {
  const BucketListWithFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController jobController = TextEditingController();
    // 현재 로그인 페이지에서는 Consumer를 사용하지 않으므로 context.read를 통해 상단에서 서비스 가져오기
    // 로그인 유저만 접속하기 때문에 null을 응답받을 일이 없으므로 nullable을 제거해준다.
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '버킷 리스트',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () {
              // 로그아웃
              authService.signOut();

              // 로그인 페이지로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              '로그아웃',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // 입력창
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // 텍스트 입력창
                Expanded(
                  child: TextField(
                    controller: jobController,
                    decoration: InputDecoration(
                      hintText: '하고 싶은 일을 입력해주세요.',
                    ),
                  ),
                ),

                // 추가 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    // create bucket
                    if (jobController.text.isNotEmpty) {
                      context
                          .read<BucketServiceWithFirebase>()
                          .create(jobController.text, user.uid);

                      jobController.text = '';
                    }
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // 경계선
          Divider(height: 1),

          // 버킷 리스트
          Expanded(
            child: Consumer<BucketServiceWithFirebase>(
              builder: (context, bucketService, _) {
                // read 기능은 시간이 걸리는 작업이기에 FutureBuilder를 통해
                // 받아오는 동안 화면을 조정할 수 있다.
                return FutureBuilder<QuerySnapshot>(
                  future: bucketService.read(user.uid),
                  builder: (context, snapshot) {
                    final documents = snapshot.data?.docs ?? []; // 문서 가져오기.

                    if (documents.isEmpty) {
                      return Center(child: Text('버킷 리스트를 작성해주세요.'));
                    }

                    return ListView.builder(
                      itemCount: documents.length, // 문서의 개수만큼
                      itemBuilder: (context, index) {
                        final doc = documents[index]; // user id에 해당되는 문서 가져오기
                        return FirebaseBucketListTile(
                          doc: doc,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
