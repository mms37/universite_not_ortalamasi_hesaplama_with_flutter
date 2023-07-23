// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled11/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('AKTS Not Ortalaması Uygulama Testi', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(AktsNotOrtalamasiApp());

    // Tap the dropdown to select course count.
    await tester.tap(find.byType(DropdownButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('4 Ders')); // Change the number of courses to 4.
    await tester.pumpAndSettle();

    // Enter course details
    for (int i = 1; i <= 4; i++) {
      await tester.enterText(find.widgetWithText(TextFormField, "Ders $i Adı:"), "Ders $i");
      await tester.enterText(find.widgetWithText(TextFormField, "Ders $i Kredisi:"), "3");
      await tester.tap(find.widgetWithText(DropdownButton, "Ders $i Notu:"));
      await tester.tap(find.text("BB")); // Enter BB grade for all courses.
      await tester.pumpAndSettle();
    }

    // Tap the hesapla button.
    await tester.tap(find.text("Ortalama Hesapla"));
    await tester.pumpAndSettle();

    // Check the result dialog.
    expect(find.text('Ortalamanız: 3.00'), findsOneWidget);
  });
}
