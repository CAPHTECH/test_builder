typedef UnitFactory<Unit, Args> = Unit Function(Args);

mixin UnitBuilder<Unit, Args> {
  late final Unit unit;
  UnitFactory<Unit, Args>? _unitFactory;
  final List<Unit Function(Unit)> _unitArrangements = [];

  void setUnitFactory(UnitFactory<Unit, Args> unitFactory) => _unitFactory = unitFactory;
  void addUnitArrangement(Unit Function(Unit) arrangement) => _unitArrangements.add(arrangement);

  Unit buildUnit(Args args) {
    if (_unitFactory == null) throw StateError('Unit factory is not set');
    return _unitArrangements.reversed.fold(_unitFactory!(args), (unit, arrangement) => arrangement(unit));
  }
}
