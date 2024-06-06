import 'package:flutter/material.dart';
import 'package:news_app_for_test/domain/usecases/get_news_usecase.dart';
import 'package:provider/provider.dart';

import 'infrastructure/service/news_api_service.dart';
import 'ui/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => NewsApiService()),
        ProxyProvider<NewsApiService, GetNewsUsecase>(
          update: (_, apiService, __) => GetNewsUsecase(apiService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
