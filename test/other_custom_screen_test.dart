import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_builder/test_builder.dart';

import 'custom_button.dart';
import 'other_custom_screen.dart';

class OtherCustomScreenDirector extends MaterialScreenWidgetDirector<(String, String, List<String>, VoidCallback)> {
  bool pressed = false;

  OtherCustomScreenDirector() {
    setUnitFactory((args) => OtherCustomScreen(
          title: args.$1,
          subtitle: args.$2,
          items: args.$3,
          onButtonPressed: args.$4,
        ));
  }

  void useDefaultScreen() => setArgs(('Test Title', 'Test Subtitle', ['Item 1', 'Item 2', 'Item 3'], () {}));

  void useScreenWithPressableButton() =>
      setArgs(('Test Title', 'Test Subtitle', ['Item 1', 'Item 2', 'Item 3'], () => pressed = true));
}

void main() {
  late OtherCustomScreenDirector director;

  setUp(() {
    director = OtherCustomScreenDirector();
  });

  group('Display confirmation', () {
    setUp(() => director.useDefaultScreen());

    testWidgets('OtherCustomScreen is displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(director.construct());
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
      expect(find.text('Execute Action'), findsOneWidget);
      expect(find.byType(CustomButton), findsOneWidget);
    });
  });

  group('Button behavior confirmation', () {
    setUp(() => director.useScreenWithPressableButton());

    testWidgets('Tapping the button calls onPressed', (WidgetTester tester) async {
      await tester.pumpWidget(director.construct());
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CustomButton));

      expect(director.pressed, isTrue);
    });
  });
}
