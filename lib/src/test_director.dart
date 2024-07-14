import 'package:flutter/foundation.dart';
import 'package:test_builder/src/unit_builder.dart';

import 'args_builder.dart';

/// A class that combines [ArgsBuilder] and [UnitBuilder] to provide a flexible
/// and reusable way to set up and construct test scenarios.
///
/// [TestDirector] is designed to be extended or used directly in test files to
/// create organized and maintainable test setups, especially for Flutter widget tests.
///
/// The [Unit] type parameter typically represents the widget or object being tested,
/// while [Args] represents the arguments used to construct the unit.
///
/// Usage:
/// ```dart
/// class MyUnitTestDirector extends TestDirector<MyClass, String> {
///   MyUnitTestDirector() {
///     setUnitFactory((args) => MyClass(value: args));
///   }
/// }
///
/// void main() {
///   late MyUnitTestDirector director;
///
///   setUp(() {
///     director = MyUnitTestDirector();
///   });
///
///   test('MyClass behaves correctly', () {
///     director.setArgs('test value');
///     final myObject = director.construct();
///     expect(myObject.value, equals('test value'));
///   });
/// }
/// ```
class TestDirector<Unit, Args> with ArgsBuilder<Args>, UnitBuilder<Unit, Args> {
  /// Constructs the [Unit] using the provided [Args].
  ///
  /// This method combines the functionality of [ArgsBuilder.buildArgs] and
  /// [UnitBuilder.buildUnit] to create the final unit for testing.
  ///
  /// @return The constructed [Unit].
  @mustCallSuper
  Unit construct() {
    final args = buildArgs();
    return buildUnit(args);
  }
}
