import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_builder/test_builder.dart';

import 'custom_button.dart';

void main() {
  late MaterialWidgetDirector<(String, VoidCallback)> director;

  setUp(() => director = MaterialWidgetDirector<(String, VoidCallback)>()
    ..setUnitFactory((args) => CustomButton(text: args.$1, onPressed: args.$2)));

  group('Display Confirmation', () {
    setUp(() => director.setArgsFactory(() => ('Test Button', () {})));

    testWidgets('Button is displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(director.construct());

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('Tap Behavior Confirmation', () {
    bool pressed = false;

    setUp(() => director.setArgs(('Test Button', () => pressed = true)));

    testWidgets('onPressed is called when button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(director.construct());
      await tester.tap(find.byType(ElevatedButton));

      expect(pressed, isTrue);
    });
  });
}
