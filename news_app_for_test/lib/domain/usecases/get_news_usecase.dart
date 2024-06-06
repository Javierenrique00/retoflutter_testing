import 'package:news_app_for_test/domain/entities/news_entity.dart';

import '../../infrastructure/service/news_api_service.dart';

class GetNewsUsecase {
  final NewsApiService apiService;

  GetNewsUsecase(this.apiService);

  Future<List<NewsEntity>> execute() async {
    final newsModels = await apiService.fetchTopHeadlines();
    return newsModels
        .map((model) => NewsEntity(
              title: model.title,
              description: model.description,
              url: model.url,
              urlToImage: model.urlToImage,
              sourceName: model.sourceName,
            ))
        .toList();
  }
}
