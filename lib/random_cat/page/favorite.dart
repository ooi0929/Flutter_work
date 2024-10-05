import 'package:flutter/material.dart';

import '../service/cat_service.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '좋아요',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
        valueListenable: CatService.instance.favoriteImages,
        builder: (context, favoriteImage, _) {
          return GridView.count(
            mainAxisSpacing: 8, // 열 간격
            crossAxisSpacing: 8, // 행 간격
            padding: EdgeInsets.all(8.0),
            crossAxisCount: 2, // 행 최대 개수
            children: List.generate(
              favoriteImage.length,
              (index) {
                var catImage = CatService.instance.catImage;
                return GestureDetector(
                  onTap: () {
                    // 사진 클릭 시
                    CatService.instance
                        .toggleFavoriteImage(catImage.value[index]);
                  },
                  child: Stack(
                    children: [
                      // 사진
                      Positioned.fill(
                        child: Image.network(
                          catImage.value[index],
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
                                      .contains(catImage.value[index])
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
