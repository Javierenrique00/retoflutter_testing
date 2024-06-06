import 'package:flutter/material.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/ui/screens/news_search_screen.dart';
import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';
import 'package:provider/provider.dart';

import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  //final TextEditingController _searchController = TextEditingController();
  List<NewsEntity> _newsList = [];
  List<NewsEntity> _filteredNewsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: NewsSearchScreen(_newsList));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<NewsEntity>>(
        future: Provider.of<GetNewsUsecase>(context).execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load news'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            _newsList = snapshot.data!;
            _filteredNewsList = _newsList;
            return ListView.builder(
              itemCount: _filteredNewsList.length,
              itemBuilder: (context, index) {
                final news = _filteredNewsList[index];
                return NewsCardWidget(
                  imagePath: news.urlToImage,
                  source: news.sourceName,
                  title: news.title,
                  onTap: () => _openNewsDetail(context, news),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _openNewsDetail(BuildContext context, NewsEntity news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news)),
    );
  }
}
