# Test Builder

Test Builder is a Dart package that provides a Builder pattern for Flutter tests. It simplifies the process of creating and managing test cases for Flutter widgets and screens.

## Features

- Flexible test setup using Builder and Director patterns
- Support for Material widgets and screens
- Easy management of test arguments and widget construction
- Reusable components for common testing scenarios

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  test_builder: ^0.1.1
```

Then run:

```
flutter pub get
```

## Usage

### Basic Usage

1. Import the package:

```dart
import 'package:test_builder/test_builder.dart';
```

2. Create a Director for your widget or screen:

```dart
late MaterialScreenWidgetDirector<(String, String, String, VoidCallback)> director;

setUp(() => director = MaterialScreenWidgetDirector<(String, String, String, VoidCallback)>()
  ..setUnitFactory((args) => CustomScreen(
        title: args.$1,
        message: args.$2,
        buttonText: args.$3,
        onButtonPressed: args.$4,
      )));
```

3. Set up your test cases:

```dart
group('Display confirmation', () {
  setUp(() => director.setArgsFactory(() => ('Test Title', 'Test Message', 'Test Button', () {})));

  testWidgets('CustomScreen is displayed correctly', (WidgetTester tester) async {
    await tester.pumpWidget(director.construct());
    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Message'), findsOneWidget);
    expect(find.text('Test Button'), findsOneWidget);
  });
});
```

### Advanced Usage

For more complex scenarios, you can create custom Directors:

```dart
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
```

## Examples

Check the `test` directory for more usage examples:

- `custom_button_test.dart`: Testing a simple custom button
- `custom_screen_test.dart`: Testing a custom screen with multiple components
- `other_custom_screen_test.dart`: Testing a more complex custom screen using a custom Director

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
