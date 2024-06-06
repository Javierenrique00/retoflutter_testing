import 'package:flutter/material.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.news});

  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            news.urlToImage.isNotEmpty
                ? Image.network(news.urlToImage)
                : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
            Text(
              news.title,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(news.description),
          ],
        ),
      ),
    );
  }
}
