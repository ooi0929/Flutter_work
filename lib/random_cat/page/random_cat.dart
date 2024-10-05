import 'package:flutter/material.dart';
import 'package:flutter_workspace/random_cat/page/favorite.dart';

import '../service/cat_service.dart';

class RandomCat extends StatefulWidget {
  const RandomCat({super.key});

  @override
  State<RandomCat> createState() => _RandomCatState();
}

class _RandomCatState extends State<RandomCat> {
  @override
  void initState() {
    super.initState();
    CatService.instance.getRandomCatImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '랜덤 고양이',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          // 좋아요 페이지로 이동
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Favorite(),
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // 고양이 사진 목록
      body: ValueListenableBuilder(
        valueListenable: CatService.instance.catImage,
        builder: (context, catImage, _) {
          return GridView.count(
            mainAxisSpacing: 8, // 열 간격
            crossAxisSpacing: 8, // 행 간격
            padding: EdgeInsets.all(8.0),
            crossAxisCount: 2, // 행 최대 개수
            children: List.generate(
              catImage.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    // 사진 클릭 시
                    CatService.instance.toggleFavoriteImage(catImage[index]);
                  },
                  child: Stack(
                    children: [
                      // 사진
                      Positioned.fill(
                        child: Image.network(
                          catImage[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      // 좋아요
                      Positioned(
                        bottom: 8.0,
                        right: 8.0,
                        child: ValueListenableBuilder(
                          valueListenable: CatService.instance.favoriteImages,
                          builder: (context, favoriteImage, _) {
                            return Icon(
                              Icons.favorite,
                              color: CatService.instance.favoriteImages.value
                                      .contains(catImage[index])
                                  ? Colors.amber
                                  : Colors.transparent,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
