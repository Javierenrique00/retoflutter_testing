import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/domain/entities/news_entity.dart';


void main(){

  test('Check Operator == is not equal with different field title', (){

    // Arrange
    final news = NewsEntity(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    final altNews = NewsEntity(title: 'title1', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    
    // Act // Assert
    expect(news, isNot(equals(altNews)));


  });

  test('Check Operator == is equal', (){

    // Arrange
    final news = NewsEntity(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    final altNews = NewsEntity(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    
    // Act // Assert
    expect(news, altNews);

  });

  test('Hash code is equal for different objects', (){

    // Arrange
    final news = NewsEntity(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    final altNews = NewsEntity(title: 'title', description: 'description1', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    // Act // Assert
  expect(news.hashCode, isNot(equals(altNews.hashCode)));

  });

  test('Hash code is equal for different objects with the same content', (){

    // Arrange
    final news = NewsEntity(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    final altNews = NewsEntity(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    // Act // Assert
  expect(news.hashCode, altNews.hashCode);

  });

}