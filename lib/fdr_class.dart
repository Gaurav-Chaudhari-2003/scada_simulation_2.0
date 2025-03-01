import 'package:flutter/cupertino.dart';

import 'circuit_components_interface.dart';
import 'customComponentsWidgets/custom_alert.dart';
import 'wire_class.dart';

class FDR extends CircuitComponent {
  final String _fdrId;
  double _currentVoltage;
  final double _mainVoltage;
  late Wire _connectedWire;
  bool _status;
  late final List<(int row, int column)> _coordinates;
  late final List<int> _quarterTurns;

  FDR({
    required String id,
    required double voltage,
    required Wire connectedWire,
    required (int row, int column) coordinates,
    required int quarterTurns
  })  : _fdrId = id,
        _currentVoltage = voltage,
        _mainVoltage = voltage,
        _connectedWire = connectedWire,
        _coordinates = [coordinates],
        _quarterTurns = [quarterTurns],
        _status = false;

  void toggle(FDR fdr) {
    _status ? _currentVoltage = 0 : _currentVoltage = _mainVoltage;
    _status = !_status;
    _connectedWire.getVoltageSourceFDR.isEmpty
        ? _connectedWire.setVoltageSourceFDR = [fdr]
        : _connectedWire.setVoltageSourceFDR = [];
  }

  static void toggleFDR(FDR fdr, Wire connectedWire, BuildContext context) {
    fdr.toggle(fdr);
    if (fdr.getStatus &&
        fdr.getConnectedWireID.getVoltage != 0.0 &&
        !fdr.getConnectedWireID.getVoltageSourceFDR.contains(fdr)) {
      CustomAlert.showAlert(
        context,
        "Short Circuit Detected!",
        "FDR ID: ${fdr.getId}\nWire ID: ${fdr.getConnectedWireID.getId}",
      );
      fdr.toggle(fdr);
      return;
    }
    Wire.updateWireVoltage(connectedWire, [fdr], fdr.getVoltage,
        connectedWire.getVoltageSourceFDR, false);
  }

  double get getVoltage => _currentVoltage;
  Wire get getConnectedWireID => _connectedWire;
  bool get getStatus => _status;


  set setVoltage(double v) => _currentVoltage = v;
  set setConnectedWireID(Wire wireID) => _connectedWire = wireID;

  @override
  String get getId =>_fdrId;
  @override
  List<(int, int)> get getCoordinates => _coordinates;
  @override
  List<int> get getQuarterTurns => _quarterTurns;
}
