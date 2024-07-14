import 'package:flutter/foundation.dart';
import 'package:test_builder/src/unit_builder.dart';

import 'args_builder.dart';

class TestDirector<Unit, Args> with ArgsBuilder<Args>, UnitBuilder<Unit, Args> {
  @mustCallSuper
  Unit construct() {
    final args = buildArgs();
    return buildUnit(args);
  }
}
