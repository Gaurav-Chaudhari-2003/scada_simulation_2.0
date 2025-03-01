import 'package:scada_simulation_2_0/circuit_components_interface.dart';
import 'wire_class.dart';

class SSP extends CircuitComponent{
  final String _sspID;
  final Wire _leftBottomWire;
  final Wire _rightUpWire;
  late final List<(int row, int column)> _coordinates;
  late final List<int> _quarterTurns;

  SSP( {
    required String sspID,
    required Wire leftBottomWire,
    required Wire rightUpWire,
    required (int row, int column) coordinates,
    required int quarterTurns
  }) :
  _sspID = sspID,
  _leftBottomWire = leftBottomWire,
  _rightUpWire = rightUpWire,
        _coordinates = [coordinates],
        _quarterTurns = [quarterTurns];


  @override
  @override
  String get getId =>_sspID;

  Wire get getRightUpWire => _rightUpWire;
  Wire get getLeftBottomWire => _leftBottomWire;
  @override
  List<(int, int)> get getCoordinates => _coordinates;
  @override
  List<int> get getQuarterTurns => _quarterTurns;
}