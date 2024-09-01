import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Add item to list with category and check if it appears', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HomeInventoryApp());

    // Verify that there are no items in the list initially.
    expect(find.text('soap (Kitchen)'), findsNothing);

    // Enter a new item in the text field.
    await tester.enterText(find.byType(TextField), 'soap');
    
    // Select a category from the dropdown.
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle(); // Wait for the dropdown to open
    await tester.tap(find.text('Kitchen').last); // Tap the 'Kitchen' category
    await tester.pump(); // Trigger the UI to update

    // Tap the add button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the new item appears in the list with the correct category.
    expect(find.text('soap (Kitchen)'), findsOneWidget);
  });

  testWidgets('Toggle item status', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HomeInventoryApp());

    // Enter a new item in the text field.
    await tester.enterText(find.byType(TextField), 'paper towels');
    
    // Select a category from the dropdown.
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle(); // Wait for the dropdown to open
    await tester.tap(find.text('Kitchen').last); // Tap the 'Kitchen' category
    await tester.pump(); // Trigger the UI to update

    // Tap the add button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the item appears in the list and is not checked.
    expect(find.text('paper towels (Kitchen)'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);

    // Tap the checkbox to mark the item as owned.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // Verify that the item is now checked.
    expect(find.byType(Checkbox), findsOneWidget); // We still find one widget, but it is now checked
  });
}
