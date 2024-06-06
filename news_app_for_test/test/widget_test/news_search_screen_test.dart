


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/ui/screens/news_detail_screen.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';
import 'package:provider/provider.dart';

import '../unit_test/get_news_usecase_test.dart';

void main(){

  testWidgets('Find last news with scroll', (tester) async {

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

    // get the scroll widget
    final scrollWidget = find.ancestor(of: find.byType(ListTile).first,matching: find.byType(Scrollable)).first;
    
    final lastItem = find.text('title99');
    await tester.scrollUntilVisible(lastItem, 40.0 ,scrollable: scrollWidget, maxScrolls: 400);
    expect(lastItem, findsOneWidget);

  });


  testWidgets('Search specific Item and tab to detail', (tester) async {

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

    await tester.enterText(find.byType(TextField), 'title99');

    await tester.pumpAndSettle();

    // find 2 items, 1 for the typed test, the other is in the searchList
    expect(find.text('title99'), findsAtLeast(2));


    // tap to go to detail
    final tileToTab = find.descendant(of: find.byType(ListTile), matching: find.text('title99'));
    await tester.tap(tileToTab);

    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    // tap to go to detail
    final tileToTab2 = find.descendant(of: find.byType(ListTile), matching: find.text('title99'));
    await tester.tap(tileToTab2);

    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    // Check navigate to detail
    expect(find.byType(NewsDetailScreen),findsOneWidget);


  });

    testWidgets('Goto searchScreen and return to listScreen', (tester) async {

    final newsApiserviceMock = MockNewsApiSerice();

    final news = NewsModel(
        title: 'title',
        description: 'description',
        url: '',
        urlToImage: '',
        sourceName: 'sourceName');

    when(() => newsApiserviceMock.fetchTopHeadlines()).thenAnswer(
      (invocation) => Future(() => [news]),
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

    // Search back Icon
    final widgetBack = find.byIcon(Icons.arrow_back);
    await tester.tap(widgetBack);

    await tester.pumpAndSettle(const Duration(milliseconds: 200));

    // --- find search button in the newsList Screen
    final findWidgetSearch2 = find.byIcon(Icons.search);
    expect(findWidgetSearch2, findsOneWidget);


  });

}