import 'package:scada_simulation_2_0/circuit_components_interface.dart';

import '../wire_class.dart';

class Transformer extends CircuitComponent {
  final String _transformerId;
  late final Wire _inputWire;
  late final Wire _outputWire;
  double _inputVoltage;
  double _outputVoltage;
  double _factor;
  late final List<(int row, int column)> _coordinates;
  late final List<int> _quarterTurns;

  Transformer({
    required String id,
    required Wire inputWire,
    required Wire outputWire,
    required (int row, int column) coordinates,
    required int quarterTurns
  })  : _transformerId = id,
        _inputWire = inputWire,
        _outputWire = outputWire,
        _inputVoltage = inputWire.getVoltage,
        _outputVoltage = inputWire.getVoltage,
        _coordinates = [coordinates],
        _quarterTurns = [quarterTurns],
        _factor = 1;

  void adjustOutputVoltage(double factor) {
    _factor = factor;
    _outputVoltage = _inputVoltage * _factor;
    Wire.updateWireVoltage(_outputWire, [this], _outputVoltage,
        _inputWire.getVoltageSourceFDR, true);
  }

  static void updateOutputVoltage(Transformer transformer) {
    transformer._inputVoltage = transformer._inputWire.getVoltage;
    transformer._outputVoltage =
        transformer._inputVoltage * transformer._factor;
    Wire.updateWireVoltage(
        transformer._outputWire,
        [transformer],
        transformer._outputVoltage,
        transformer._inputWire.getVoltageSourceFDR,
        false);
  }

  String get id => _transformerId;
  double get getFactor => _factor;
  Wire get getInputWire => _inputWire;
  Wire get getOutputWire => _outputWire;
  double get getInputVoltage => _inputVoltage;
  double get getOutputVoltage => _outputVoltage;

  set setInputWire(Wire value) => _inputWire = value;
  set setFactor(double value) => _factor = value;
  set setOutputWire(Wire value) => _outputWire = value;
  set setInputVoltage(double value) => _inputVoltage = value;
  set setOutputVoltage(double value) => _outputVoltage = value;


  @override
  String get getId => _transformerId;
  @override
  List<(int, int)> get getCoordinates => _coordinates;
  @override
  List<int> get getQuarterTurns => _quarterTurns;
}
