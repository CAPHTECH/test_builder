import 'package:flutter/foundation.dart';

/// A typedef for a function that creates [Args].
typedef ArgsFactory<Args> = Args Function();

/// A mixin that provides functionality for managing and building arguments in test scenarios.
///
/// This mixin is typically used in conjunction with [TestDirector] to create
/// flexible and reusable test setups, especially for Flutter widget tests.
///
/// The [Args] type parameter represents the type of arguments used to construct the unit under test.
mixin ArgsBuilder<Args> {
  /// The built arguments, available after [buildArgs] is called.
  late final Args args;

  /// The internally stored arguments, set by [setArgs].
  Args? _args;

  /// The factory function used to create arguments, set by [setArgsFactory].
  ArgsFactory<Args>? _argsFactory;

  /// Sets the factory function used to create arguments.
  ///
  /// This method is an alternative to [setArgs] and allows for dynamic argument creation.
  void setArgsFactory(covariant ArgsFactory<Args> argsFactory) =>
      _argsFactory = argsFactory;

  /// Sets the arguments directly.
  ///
  /// This method is an alternative to [setArgsFactory] and allows for static argument setting.
  void setArgs(Args args) => _args = args;

  /// Builds the arguments using either the set args or the args factory.
  ///
  /// This method must be called before accessing [args].
  /// Throws a [StateError] if neither [setArgs] nor [setArgsFactory] has been called,
  /// unless [Args] is [void].
  ///
  /// @return The built arguments.
  @mustCallSuper
  Args buildArgs() {
    Type getType<T>() => T;
    final voidType = getType<void>();

    final requiredArgs = _args ?? _argsFactory?.call();
    if (requiredArgs == null && Args != voidType) {
      throw StateError('args is required');
    }
    this.args = requiredArgs as Args;

    return args;
  }
}
