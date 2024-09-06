// 홈페이지
import 'package:dev_story_project/textbook/ch03/ch03-2/create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 전체 버킷리스트 목록
  List<String> bucketList = ['여행가기'];

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
      body: bucketList.isEmpty
          ? Center(child: Text('버킷 리스트를 작성해 주세요.'))
          : ListView.builder(
              itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
              itemBuilder: (context, index) {
                String bucket = bucketList[index]; // index에 해당하는 bucket 가져오기

                return ListTile(
                  // 버킷 리스트 할 일
                  title: Text(
                    bucket,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    onPressed: () {
                      // 삭제 버튼 클릭시
                    },
                    icon: Icon(
                      CupertinoIcons.delete,
                    ),
                  ),
                  onTap: () {
                    // 아이템 클릭시
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        onPressed: () {
          // + 버튼 클릭시 버킷 생성 페이지로 이동
          // .of(context)를 함께 사용해주면 미리 context 위치를 알려주었기 때문에 파라미터에 context를 넣지 않아도 된다.
          // .push()만 사용하게되면 위젯의 위치를 알려주지 않았기 때문에 context 파라미터를 추가해주어야 한다.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreatePage(),
            ),
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
