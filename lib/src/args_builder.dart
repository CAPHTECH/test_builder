import 'package:flutter/foundation.dart';

typedef ArgsFactory<Args> = Args Function();

mixin ArgsBuilder<Args> {
  late final Args args;
  Args? _args;

  ArgsFactory<Args>? _argsFactory;

  void setArgsFactory(covariant ArgsFactory<Args> argsFactory) => _argsFactory = argsFactory;

  void setArgs(Args args) => _args = args;

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
