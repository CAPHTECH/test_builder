import 'package:flutter/material.dart';

import 'test_director.dart';

/// A specialized [TestDirector] for testing Flutter widgets that require a [MaterialApp] wrapper.
///
/// This director automatically wraps the target widget with a [MaterialApp], making it suitable
/// for testing screens or full-page widgets that depend on Material Design context.
///
/// Usage:
/// ```dart
/// void main() {
///   late MaterialScreenWidgetDirector<(String, String)> director;
///
///   setUp(() {
///     director = MaterialScreenWidgetDirector<(String, String)>()
///       ..setUnitFactory((args) => MyScreen(title: args.$1, subtitle: args.$2));
///   });
///
///   testWidgets('MyScreen displays correctly', (WidgetTester tester) async {
///     director.setArgs(('Test Title', 'Test Subtitle'));
///     await tester.pumpWidget(director.construct());
///     // Perform your test assertions here
///   });
/// }
/// ```
///
/// @test For a complete example, see:
class MaterialScreenWidgetDirector<Args> extends TestDirector<Widget, Args> {
  void useMaterialApp() => addUnitArrangement((target) => MaterialApp(home: target));

  @override
  Widget construct({Args? args}) {
    useMaterialApp();
    return super.construct();
  }
}

/// A specialized [TestDirector] for testing individual Flutter widgets that require
/// basic Material Design context.
///
/// This director automatically wraps the target widget with [Material] and [Directionality],
/// providing the necessary context for Material Design widgets to function properly in tests.
///
/// Usage:
/// ```dart
/// void main() {
///   late MaterialWidgetDirector<(String, VoidCallback)> director;
///
///   setUp(() {
///     director = MaterialWidgetDirector<(String, VoidCallback)>()
///       ..setUnitFactory((args) => MyButton(text: args.$1, onPressed: args.$2));
///   });
///
///   testWidgets('MyButton displays and functions correctly', (WidgetTester tester) async {
///     bool pressed = false;
///     director.setArgs(('Test Button', () => pressed = true));
///     await tester.pumpWidget(director.construct());
///     await tester.tap(find.byType(MyButton));
///     expect(pressed, isTrue);
///   });
/// }
/// ```
///
/// @test For a complete example, see:
class MaterialWidgetDirector<Args> extends TestDirector<Widget, Args> {
  void useMaterial() => addUnitArrangement((target) => Material(child: target));
  void useDirectionality([TextDirection textDirection = TextDirection.ltr]) =>
      addUnitArrangement((target) => Directionality(textDirection: textDirection, child: target));

  @override
  Widget construct({Args? args}) {
    useMaterial();
    useDirectionality();
    return super.construct();
  }
}
