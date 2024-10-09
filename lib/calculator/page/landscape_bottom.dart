import 'package:flutter/material.dart';

import '../component/keyboard.dart';
import '../const/key_list.dart';

class LandscapeBottom extends StatelessWidget {
  const LandscapeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // 부모 위젯의 크기를 받아와 responsive UI 고려해서 자식 위젯 배치
      builder: (context, constraints) {
        double mainAxisSpacing = 10; // 주축 간격 설정
        double crossAxisSpacing = 20; // 반대축 간격 설정
        double padding = 10; // 패딩값 설정

        final horizontalLength = keyList[0].length; // 행 개수 설정
        final verticalLength = keyList.length; // 열 개수 설정

        final itemCount = verticalLength * horizontalLength; // 행 * 열 = 총개수 설정
        final maxCrossAxisExtent =
            constraints.maxWidth / horizontalLength; // 행 요소 크기 설정
        final mainAxisExtent = (constraints.maxHeight -
                (mainAxisSpacing * (verticalLength - 1)) -
                (padding * 2)) /
            verticalLength; // 열 요소 크기 설정 [최대 높이 - 주축간격 * 열 개수 - 패딩 * 2]

        return ColoredBox(
          color: Colors.grey,
          child: GridView.builder(
            itemCount: itemCount,
            shrinkWrap: true, // 화면에 보이는 요소들만 렌더링해서 보여줌
            padding: EdgeInsets.all(padding),
            physics: NeverScrollableScrollPhysics(), // 스크롤 없애기
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              // 그리드 요소들의 크기, 간격 설정
              maxCrossAxisExtent: maxCrossAxisExtent,
              mainAxisExtent: mainAxisExtent,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
            ),
            itemBuilder: (context, index) {
              int e = (index / horizontalLength)
                  .floor(); // floor()를 통해 소수점 제거 (최대 크기의 소수점은 반올림)
              int g = (index % horizontalLength)
                  .floor(); // keyList에서 각각의 행, 열에 해당되는 값을 찾아서 매개변수로 넘겨주기

              Color color;
              if (g == 3) {
                color = Colors.pink;
              } else if (e == 0) {
                color = Colors.green;
              } else {
                color = Colors.white;
              }

              return Keyboard(
                keyboard: keyList[e][g],
                color: color,
              );
            },
          ),
        );
      },
    );
  }
}
