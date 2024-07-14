/// A typedef for a function that creates a [Unit] from [Args].
typedef UnitFactory<Unit, Args> = Unit Function(Args);

/// A mixin that provides functionality for building and arranging units in test scenarios.
///
/// This mixin is typically used in conjunction with [TestDirector] to create
/// flexible and reusable test setups for Flutter widgets and other units.
///
/// The [Unit] type parameter represents the type of object being built (e.g., a Widget),
/// while [Args] represents the type of arguments used to construct the unit.
///
/// Usage:
/// ```dart
/// class MyTestDirector extends TestDirector<Widget, String> {
///   MyTestDirector() {
///     setUnitFactory((args) => MyWidget(text: args));
///     addUnitArrangement((widget) => Container(child: widget));
///   }
/// }
/// ```
mixin UnitBuilder<Unit, Args> {
  /// The built unit, available after [buildUnit] is called.
  late final Unit unit;

  /// The factory function used to create the initial unit.
  UnitFactory<Unit, Args>? _unitFactory;

  /// A list of functions that modify or wrap the unit after its initial creation.
  final List<Unit Function(Unit)> _unitArrangements = [];

  /// Sets the factory function used to create the initial unit.
  ///
  /// This method must be called before [buildUnit] is invoked.
  void setUnitFactory(UnitFactory<Unit, Args> unitFactory) => _unitFactory = unitFactory;

  /// Adds an arrangement function to modify or wrap the unit after its initial creation.
  ///
  /// Arrangements are applied in reverse order of addition, allowing for nested wrapping.
  void addUnitArrangement(Unit Function(Unit) arrangement) => _unitArrangements.add(arrangement);

  /// Builds the unit using the factory and applies all arrangements.
  ///
  /// Throws a [StateError] if [setUnitFactory] has not been called.
  ///
  /// @param args The arguments to pass to the unit factory.
  /// @return The built and arranged unit.
  Unit buildUnit(Args args) {
    if (_unitFactory == null) throw StateError('Unit factory is not set');
    return _unitArrangements.reversed.fold(_unitFactory!(args), (unit, arrangement) => arrangement(unit));
  }
}
