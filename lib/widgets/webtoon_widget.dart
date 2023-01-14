import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/screens/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  WebtoonWidget({
    super.key,
    required String title,
    required String thumb,
    required String id,
  }) : webtoon = Webtoon(title: title, thumb: thumb, id: id);
  final Webtoon webtoon;

  const WebtoonWidget.fromWebtoon(
    this.webtoon, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(webtoon: webtoon),
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: webtoon.id,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(5, 5),
                      spreadRadius: 0.1,
                    ),
                  ],
                ),
                width: 250,
                child: Image.network(
                  webtoon.thumb,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
