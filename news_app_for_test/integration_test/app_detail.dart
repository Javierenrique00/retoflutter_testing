import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app_for_test/main.dart' as app;
import 'package:news_app_for_test/ui/screens/news_detail_screen.dart';
import 'package:news_app_for_test/ui/screens/news_list_screen.dart';
import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';

void main(){

  testWidgets('test navigate to detail in first news', (tester) async {
    app.main();

    await tester.pumpAndSettle(const Duration(seconds: 5));
    
    // test navigate to new Screen in at least 5 seconds
    expect(find.byType(NewsListScreen),findsOneWidget);

    await tester.tap(find.byType(NewsCardWidget).first);

    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Check navigate to NewsdetailScreen
    expect(find.byType(NewsDetailScreen),findsOneWidget);

  });

}