
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/infrastructure/service/news_api_service.dart';
import 'package:news_app_for_test/ui/screens/news_detail_screen.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';
import 'package:provider/provider.dart';

class MockNewsApiSerice extends Mock implements NewsApiService {}

void main(){

  testWidgets('check Scroll 100 news to find the last one', (tester) async {

    final newsApiserviceMock = MockNewsApiSerice();

    final newsList = List<NewsModel>.generate(100,(int index) => NewsModel(
        title: 'title$index',
        description: 'description$index',
        url: '',
        urlToImage: '',
        sourceName: 'sourceName'));

    when(() => newsApiserviceMock.fetchTopHeadlines()).thenAnswer(
      (invocation) => Future(() => newsList),
    );

    await tester.pumpWidget(Provider<GetNewsUsecase>(
      create: (_) => GetNewsUsecase(newsApiserviceMock),
      child: const MaterialApp(
        home: Scaffold(
          body: NewsListScreen(),
        ),
      ),
    ));

    await tester.pumpAndSettle(const Duration(milliseconds: 300));

    // Scroll until find last news --> 99
    final itemFinder = find.text('title99');
    await tester.scrollUntilVisible(itemFinder, 220.0 ,scrollable: find.byType(Scrollable));
    expect(itemFinder, findsOneWidget);

  });

    testWidgets('Tab in the first news to navigate to detail', (tester) async {

    final newsApiserviceMock = MockNewsApiSerice();

    const textToFind = 'title';
    final news1 = NewsModel(
        title: textToFind,
        description: 'description',
        url: '',
        urlToImage: '',
        sourceName: 'sourceName');

    when(() => newsApiserviceMock.fetchTopHeadlines()).thenAnswer(
      (invocation) => Future(() => [news1]),
    );

    await tester.pumpWidget(Provider<GetNewsUsecase>(
      create: (_) => GetNewsUsecase(newsApiserviceMock),
      child: const MaterialApp(
        home: Scaffold(
          body: NewsListScreen(),
        ),
      ),
    ));

    await tester.pumpAndSettle(const Duration(milliseconds: 300));

    // find the item to tap
    final candidates = find.text(textToFind);
    expect(candidates, findsOneWidget);

    // tab at the news to navigate to detail
    await tester.tap(candidates);

    await tester.pumpAndSettle(const Duration(milliseconds: 300));

    // Check navigate to NewsdetailScreen
    expect(find.byType(NewsDetailScreen),findsOneWidget);

  });


  testWidgets('Tab to navigate to searchNews', (tester) async {

    final newsApiserviceMock = MockNewsApiSerice();

    final news1 = NewsModel(
        title: 'title',
        description: 'description',
        url: '',
        urlToImage: '',
        sourceName: 'sourceName');

    when(() => newsApiserviceMock.fetchTopHeadlines()).thenAnswer(
      (invocation) => Future(() => [news1]),
    );

    await tester.pumpWidget(Provider<GetNewsUsecase>(
      create: (_) => GetNewsUsecase(newsApiserviceMock),
      child: const MaterialApp(
        home: Scaffold(
          body: NewsListScreen(),
        ),
      ),
    ));

    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    // --- find search button
    final findWidgetSearch = find.byIcon(Icons.search);
    expect(findWidgetSearch, findsOneWidget);

    // tab at the Search Icon to go to Search
    await tester.tap(findWidgetSearch);

    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    final findWidgetClear = find.byIcon(Icons.clear);

    // Check navigate to NewsSearchScreen with a clear Icon
    expect(findWidgetClear,findsOneWidget);

  });

  testWidgets('Failed Apiservice - check message when cant´t get data', (tester) async {

  final newsApiserviceMock = MockNewsApiSerice();
  when(()=> newsApiserviceMock.fetchTopHeadlines()).thenThrow(Exception()); 


  await tester.pumpWidget(Provider<GetNewsUsecase>(
    create: (_) => GetNewsUsecase(newsApiserviceMock),
    child: const MaterialApp(
      home: Scaffold(
        body: NewsListScreen(),
      ),
    ),
  ));

  await tester.pumpAndSettle();

  // Check message
  expect(find.text('Failed to load news'), findsOneWidget);


  });

}