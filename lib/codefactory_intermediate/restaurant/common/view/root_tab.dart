import 'package:flutter/material.dart';

import '../../order/view/order_screen.dart';
import '../../product/view/product_screen.dart';
import '../../restaurant/view/restaurant_screen.dart';
import '../../user/view/profile_screen.dart';
import '../const/colors.dart';
import '../layout/default_layout.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with TickerProviderStateMixin {
  // Tab을 제어할 인덱스
  int index = 0;

  // TabBarView를 제어할 컨트롤러
  late TabController controller;

  @override
  void initState() {
    super.initState();

    // vsync: 렌더링엔진에서 사용되는건데 현재 컨트롤러를 사용하는 State or StatefulWidget을 넣어주면 된다.
    // 단, this는 특정 기능을 가지고 있어야 한다.
    // TickerProviderStateMixin을 반드시 믹스인 해줘야 추가됨.
    controller = TabController(length: 4, vsync: this);

    // currentIndex의 index를 제어하기 위해
    // listener: 특정 값이 변경될 때 함수를 실행하라.
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  // 메모리누수 방지를 위해
  // 컨트롤러를 사용하면 반드시 삭제
  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        // 선택된 색상
        selectedItemColor: PRIMARY_COLOR,
        // 선택되지 않은 색상
        unselectedItemColor: BODY_TEXT_COLOR,
        // 선택된 폰트 크기
        selectedFontSize: 10,
        // 선택되지 않은 폰트 크기
        unselectedFontSize: 10,
        // 타입
        // shifting(기본값): 선택을 할 때마다 선택된 탭이 더 크게 표현됨 (확대)
        // fixed: 선택된 탭은 고정된다.
        type: BottomNavigationBarType.fixed,
        // 탭했을 때
        onTap: (int index) {
          // 애니메이션해라 어디로? index로
          controller.animateTo(index);
        },
        // 선택된 인덱스
        currentIndex: index,
        // 네비게이션 아이템
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
      child: TabBarView(
        // 스크롤 제어
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          ProductScreen(),
          OrderScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
