import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/infrastructure/service/news_api_service.dart';

class MockNewsApiSerice extends Mock implements NewsApiService{}

void main(){

  test('News Apiservice.fetchTopHeadlines success', () async {

    // Arrange
    final newsApiserviceMock = MockNewsApiSerice();
    final news = NewsModel(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    when(()=> newsApiserviceMock.fetchTopHeadlines()).thenAnswer((invocation) => Future(() => [news]),); 
    final getNewsUsecase = GetNewsUsecase(newsApiserviceMock);

    // act
    final result = await getNewsUsecase.execute();

    //assert
    final newsEntity = NewsEntity(title: news.title, description: news.description, url: news.url, urlToImage: news.urlToImage, sourceName: news.sourceName);
    expect(result.first, newsEntity);

  });

    test('News Apiservice.fetchTopHeadlines failure', () async {

    // Arrange
    final newsApiserviceMock = MockNewsApiSerice();
    when(()=> newsApiserviceMock.fetchTopHeadlines()).thenThrow(Exception()); 

    //act //assert
    expect( () async => await GetNewsUsecase(newsApiserviceMock).execute(), throwsException);

  });

}