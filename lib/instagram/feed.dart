import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl; // 이미지를 담을 변수

  @override
  Widget build(BuildContext context) {
    // 좋아요 여부
    final isFavorite = ValueNotifier(false);

    return Column(
      children: [
        // 이미지
        Image.network(
          imageUrl, // imageUrl 가져오기
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        // 아이콘 목록
        Row(
          children: [
            IconButton(
              onPressed: () {
                // 해당 값이 변경될 때
                isFavorite.value = !isFavorite.value;
              },
              icon: ValueListenableBuilder(
                // 해당 부분만 화면 갱신
                valueListenable: isFavorite,
                builder: (context, isFavorite, _) {
                  return Icon(
                    CupertinoIcons.heart,
                    color: isFavorite ? Colors.pink : Colors.black,
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bookmark,
                color: Colors.black,
              ),
            ),
            // 빈 공간 추가
            Spacer(),
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
        Text(
          '2 likes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // 설명
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's staring at me. Isn't it so cute??",
          ),
        ),
        // 날짜
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FEBURARY 6",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
