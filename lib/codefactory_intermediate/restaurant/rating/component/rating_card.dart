import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../common/const/colors.dart';
import '../model/rating_model.dart';

class RatingCard extends StatelessWidget {
  // NetworkImage
  // AssetImage
  //
  // CircleAvatar
  final ImageProvider avatarImage;
  // 리스트로 위젯 이미지를 보여줄 때
  final List<Image> images;
  // 별점
  final int rating;
  // 이메일
  final String email;
  // 리뷰 내용
  final String content;

  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  });

  factory RatingCard.fromModel({
    required RatingModel model,
  }) {
    return RatingCard(
      avatarImage: NetworkImage(
        model.user.imageUrl,
      ),
      images: model.imgUrls
          .map(
            (e) => Image.network(e),
          )
          .toList(),
      rating: model.rating,
      email: model.user.username,
      content: model.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        SizedBox(height: 8.0),
        _Body(
          content: content,
        ),
        // ignore: prefer_is_empty
        if (images.length > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 100,
              child: _Images(
                images: images,
              ),
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header({
    required this.avatarImage,
    required this.rating,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 원형 프로필 이미지나 아이콘을 표시하기 위해 주로 사용되는 위젯
        CircleAvatar(
          radius: 12.0,
          backgroundImage: avatarImage,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // 별점
        // 리스트의 값들을 풀어서 넣고 싶을 때
        ...List.generate(
          5,
          (index) => Icon(
            // true: 채워진 별점
            // false: 안채워진 별점
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Text를 Flexible 위젯으로 감싸게 되면
        // 글자가 오른쪽으로 쭉 써질 때
        // 크기를 넘어가게되면 다음줄로 알아서 넘어가도록 설계되어있다.
        //
        // Flexible을 안 넣게되면 오버플로우 발생.
        Flexible(
          child: Text(
            content,
            style: TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      // 스크롤을 좌,우로 할 수 있도록 설정
      scrollDirection: Axis.horizontal,
      // map()을 사용할 때
      // index도 같이 받을 순 없나?
      // 다른 프레임워크들은 되는데...

      // package:collection/collection.dart 임포트하는순간 (dart sdk에서 제공)
      // mapIndexed()를 통해 인덱스도 받을 수 있다.
      children: images
          .mapIndexed(
            (index, element) => Padding(
              padding: EdgeInsets.only(
                // index가 마지막 이미지이면
                // 패딩을 넣지 않고
                // 나머지는 패딩을 16만큼 넣겠다.
                right: index == images.length - 1 ? 0 : 16.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: element,
              ),
            ),
          )
          .toList(),
    );
  }
}
