import 'package:flutter/material.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';

import 'news_detail_screen.dart';

class NewsSearchScreen extends SearchDelegate<NewsEntity> {
  final List<NewsEntity> newsList;

  NewsSearchScreen(this.newsList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = newsList
        .where((news) =>
            news.title.toLowerCase().contains(query.toLowerCase()) ||
            news.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final news = results[index];
          return ListTile(
            title: Text(news.title),
            subtitle: Text(news.description),
            leading: news.urlToImage.isNotEmpty
                ? Image.network(news.urlToImage, width: 100, fit: BoxFit.cover)
                : null,
            onTap: () {
              close(context, news);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(news: news),
                ),
              );
            },
          );
        },
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = newsList
        .where((news) =>
            news.title.toLowerCase().contains(query.toLowerCase()) ||
            news.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final news = suggestions[index];
        return ListTile(
          title: Text(news.title),
          subtitle: Text(news.description),
          leading: news.urlToImage.isNotEmpty
              ? Image.network(news.urlToImage, width: 100, fit: BoxFit.cover)
              : null,
          onTap: () {
            query = news.title;
            showResults(context);
          },
        );
      },
    );
  }
}
