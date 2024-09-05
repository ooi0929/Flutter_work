import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  // 이미지를 담을 변수
  final String imageUrl;

  const Feed({
    super.key,
    required this.imageUrl, // 현재 클래스의 인스턴스를 생성할 때 필수로 받아야할 값.
  });

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // 좋아요 여부
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이미지
        Image.network(
          widget.imageUrl, // widget 키워드를 통해 상태클래스에 상위 클래스의 속성들에 접근 가능.
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover, // 이미지의 비율을 유지하면서 고정된 폭, 높이 맞춰주기.
        ),
        // 아이콘 목록
        Row(
          children: [
            IconButton(
              onPressed: () {
                // 화면 갱신 - 빌드함수 재실행
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                CupertinoIcons.heart,
                color: isFavorite ? Colors.pink : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.black,
              ),
            ),
            Spacer(), // 빈 공간 추가
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bookmark,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // 좋아요
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '2 likes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // 설명
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's and staring at me. Isn't It so cute??",
          ),
        ),
        // 날짜
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'FEBURARY 6',
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}
