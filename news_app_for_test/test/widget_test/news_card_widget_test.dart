
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news_app_for_test/ui/widgets/news_card_widget.dart';

void main(){

  testWidgets('widget has title and source data set', (tester) async {

    const title = 'title';
    const source = 'source';
    final widget = Directionality(textDirection: TextDirection.ltr, child: NewsCardWidget(imagePath: '', source: source, title: title, onTap:(){},),);
    await tester.pumpWidget(widget);

    await tester.pumpAndSettle();

    // Verify title is set
    expect(find.text(title), findsOneWidget);
    
    // Verify source is set
    expect(find.text(source), findsOneWidget);

  });


}