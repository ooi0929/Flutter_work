import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cat_service.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '랜덤 고양이',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Consumer<CatService>(
        builder: (context, catService, child) {
          return GridView.count(
            mainAxisSpacing: 8, // 세로 간격
            crossAxisSpacing: 8, // 가로 간격
            padding: EdgeInsets.all(8.0),
            crossAxisCount: 2,
            children: List.generate(
              catService.favoriteImages.length, // 보여주려는 항목 개수
              (index) {
                String catImage = catService.favoriteImages[index]; // 보여주려는 항목
                return GestureDetector(
                  onTap: () {
                    // 사진 클릭시
                    catService.toggleFavoriteImage(catImage);
                  },
                  child: Stack(
                    children: [
                      // 사진
                      Positioned.fill(
                        child: Image.network(
                          catImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // 좋아요
                      Positioned(
                        bottom: 8.0,
                        right: 8.0,
                        child: Icon(
                          Icons.favorite,
                          color: catService.favoriteImages.contains(catImage)
                              ? Colors.amber
                              : Colors.transparent,
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
