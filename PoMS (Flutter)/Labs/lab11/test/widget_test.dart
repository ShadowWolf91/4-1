import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/presentation/pages/home_page.dart';

void main() {
  testWidgets('HomePage Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verify that AppBar title is rendered
    expect(find.text('HomePage'), findsOneWidget);

    // Tap on the Floating Action Button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that AlertDialog content is rendered
    expect(find.byType(AlertDialog), findsOneWidget);

    // You can perform more widget testing scenarios/assertions here
  });
}
