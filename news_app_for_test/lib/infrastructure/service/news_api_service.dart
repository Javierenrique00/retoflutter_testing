import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_for_test/infrastructure/extensions/http_overrides_extension.dart';
import 'dart:io';
import '../models/news_model.dart';

class NewsApiService {
  static const String _apiKey = '----put apikey---';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsModel>> fetchTopHeadlines() async {
    HttpOverrides.global = HttpOverridesExtension();
    final response = await http
        .get(Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      final news = articles.map((json) => NewsModel.fromJson(json)).toList();
      return news;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
