import 'package:flutter/material.dart';

import 'test_director.dart';

class MaterialScreenWidgetDirector<Args> extends TestDirector<Widget, Args> {
  void useMaterialApp() => addUnitArrangement((target) => MaterialApp(home: target));

  @override
  Widget construct({Args? args}) {
    useMaterialApp();
    return super.construct();
  }
}

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
