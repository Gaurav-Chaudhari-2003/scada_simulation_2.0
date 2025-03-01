import 'package:scada_simulation_2_0/circuit_components_interface.dart';
import 'wire_class.dart';

class SP extends CircuitComponent{
  final String _spID;
  final Wire _leftBottomWire;
  final Wire _rightUpWire;
  late final List<(int row, int column)> _coordinates;
  late final List<int> _quarterTurns;

  SP( {
    required String sspID,
    required Wire leftBottomWire,
    required Wire rightUpWire,
    required (int row, int column) coordinates,
    required int quarterTurns
  }) :
        _spID = sspID,
        _leftBottomWire = leftBottomWire,
        _rightUpWire = rightUpWire,
        _coordinates = [coordinates],
        _quarterTurns = [quarterTurns];

  @override
  String get getId =>_spID;


  Wire get getRightUpWire => _rightUpWire;
  Wire get getLeftBottomWire => _leftBottomWire;
  @override
  List<(int, int)> get getCoordinates => _coordinates;
  @override
  List<int> get getQuarterTurns => _quarterTurns;
}