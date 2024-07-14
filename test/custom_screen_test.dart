import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_builder/test_builder.dart';

import 'custom_button.dart';
import 'custom_screen.dart';

void main() {
  late MaterialScreenWidgetDirector<(String, String, String, VoidCallback)> director;

  setUp(() => director = MaterialScreenWidgetDirector<(String, String, String, VoidCallback)>()
    ..setUnitFactory((args) => CustomScreen(
          title: args.$1,
          message: args.$2,
          buttonText: args.$3,
          onButtonPressed: args.$4,
        )));

  group('Display confirmation', () {
    setUp(() => director.setArgsFactory(() => ('Test Title', 'Test Message', 'Test Button', () {})));

    testWidgets('CustomScreen is displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(director.construct());
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(CustomButton), findsOneWidget);
    });
  });

  group('Button behavior confirmation', () {
    bool pressed = false;

    setUp(() => director.setArgs(('Test Title', 'Test Message', 'Test Button', () => pressed = true)));

    testWidgets('Tapping the button calls onPressed', (WidgetTester tester) async {
      await tester.pumpWidget(director.construct());
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CustomButton));

      expect(pressed, isTrue);
    });
  });
}
