import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:news_app_for_test/infrastructure/models/news_model.dart';
import 'package:news_app_for_test/infrastructure/service/news_api_service.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';
import 'package:news_app_for_test/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class MockNewsApiSerice extends Mock implements NewsApiService {}

void main() {
  testWidgets('check splash show test data success', (tester) async {
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
          body: SplashScreen(),
        ),
      ),
    ));

    await tester.pumpAndSettle(const Duration(seconds: 1));
    // test splash message in screen
    expect(find.text('News App'), findsOneWidget);

    // test navigate to new Screen in at least 2 seconds
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(NewsListScreen),findsOneWidget);

  });
}
