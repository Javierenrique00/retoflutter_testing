import 'dart:convert' as convert;
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';


void main() {
  
  test('Serialization - toJson', (){

    // Arrange
    final news = NewsModel(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'sourceName');
    const resultExpected = '{"title":"title","description":"description","url":"url","urlToImage":"urlToImage"}';

    // Act
    final jsonMap = news.toJson();
    final jsonStr = convert.jsonEncode(jsonMap);

    // Assert
    expect(jsonStr,resultExpected);

  });

    test('Serialization - FromJson', (){

    // Arrange
    final news = NewsModel(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'name');
    const jsonStr = '{"title":"title","description":"description","url":"url","urlToImage":"urlToImage","source":{"name":"name"}}';

    // Act
    final jsonMapRecover = convert.jsonDecode(jsonStr);
    final modelRecover = NewsModel.fromJson(jsonMapRecover);

    // Assert
    expect(modelRecover,news);


  });

  test('hashCode, different objects with sane fields has same hashcode', (){

    // Arrange
    final news = NewsModel(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'name');
    final newsAlt = NewsModel(title: 'title', description: 'description', url: 'url', urlToImage: 'urlToImage', sourceName: 'name');


    // Act // Assert
    expect(news.hashCode, newsAlt.hashCode );

  });



}