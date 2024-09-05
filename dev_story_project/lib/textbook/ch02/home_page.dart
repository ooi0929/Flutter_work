import 'package:dev_story_project/textbook/ch02/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // image URL 리스트
    final List<String> images = [
      "https://i.ibb.co/CQxfdHY/cat1.jpg",
      "https://i.ibb.co/w6wxdrQ/cat2.jpg",
      "https://i.ibb.co/GnwVqCd/cat3.jpg",
      "https://i.ibb.co/1GMKYBy/cat4.jpg",
      "https://i.ibb.co/cTGzTTX/cat5.jpg",
      "https://i.ibb.co/47Y5Ct5/cat6.jpg",
      "https://i.ibb.co/ZW38ngD/cat7.gif",
    ];

    return Scaffold(
      appBar: AppBar(
        // 좌측 아이콘 버튼
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.camera,
            color: Colors.black,
          ),
        ),
        // 중앙 제목: 인스타로고
        title: Image.asset(
          'assets/ch02/logo.png',
          height: 32.0,
        ),
        centerTitle: true,
        actions: [
          // 우측 아이콘 버튼
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.paperplane,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: images.length, // 이미지 개수만큼 보여주기
        itemBuilder: (context, index) {
          final image = images[index]; // index에 해당하는 이미지

          return Feed(
            imageUrl: image, // imageUrl 전달
          );
        },
      ),
    );
  }
}
