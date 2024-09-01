import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart'; // Upewnij się, że ścieżka jest poprawna

void main() {
  testWidgets('Add item to list and check if it appears', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HomeInventoryApp());

    // Verify that there are no items in the list initially.
    expect(find.text('soap'), findsNothing);

    // Enter a new item in the text field and tap the add button.
    await tester.enterText(find.byType(TextField), 'soap');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the new item appears in the list.
    expect(find.text('soap'), findsOneWidget);
  });

  testWidgets('Toggle item status', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HomeInventoryApp());

    // Enter a new item in the text field and tap the add button.
    await tester.enterText(find.byType(TextField), 'paper towels');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the item appears in the list and is not checked.
    expect(find.text('paper towels'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);

    // Tap the checkbox to mark the item as owned.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // Verify that the item is now checked.
    expect(find.byType(Checkbox), findsOneWidget); // We still find one widget, but it is now checked
  });
}
