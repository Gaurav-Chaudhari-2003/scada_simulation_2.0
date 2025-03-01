import 'package:flutter/cupertino.dart';
import 'package:scada_simulation_2_0/sp_class.dart';
import 'package:scada_simulation_2_0/ssp_class.dart';
import 'package:scada_simulation_2_0/transformer_class.dart';
import 'package:scada_simulation_2_0/switch_class.dart';

import 'circuit_components_interface.dart';
import 'fdr_class.dart';

class Wire extends CircuitComponent {
  final String _wireId;
  double _voltage;
  late List<CircuitComponent> _connectedComponents;
  List<CircuitComponent> _voltageComingFromComponents;
  late List<FDR> _voltageSourceFDR;
  final ValueNotifier<double> voltageNotifier;
  late List<(int row, int column)> _coordinates = List.empty(growable: true);
  late final List<int> _quarterTurns;

  Wire({
    required String id,
    required List<CircuitComponent> connectedComponents,
  })  : _wireId = id,
        _voltage = 0.0,
        _connectedComponents = connectedComponents,
        _voltageComingFromComponents = [],
        _voltageSourceFDR = [],
        voltageNotifier = ValueNotifier(0);

  static void updateWireVoltage(
      Wire wire,
      List<CircuitComponent> voltageComingFromComponentID,
      double comingVoltage,
      List<FDR> voltageSourceFDR,
      bool isUpdateVoltage) {
    if (comingVoltage != 0) {
      if (wire.getConnectedComponents
                  .contains(voltageComingFromComponentID[0]) &&
              !wire.getVoltageComingFromComponents
                  .contains(voltageComingFromComponentID[0]) ||
          isUpdateVoltage) {
        wire.setVoltage = comingVoltage;
        wire.setVoltageComingFromComponents = [voltageComingFromComponentID[0]];
        wire.setVoltageSourceFDR = voltageSourceFDR;
      }
    } else {
      if (wire.getVoltageComingFromComponents
          .contains(voltageComingFromComponentID[0])) {
        wire.getVoltageComingFromComponents
            .remove(voltageComingFromComponentID[0]);
        wire.setVoltage = comingVoltage;
        wire.setVoltageSourceFDR = [];
      }
    }

    // Voltage propagation
    propagateVoltage(wire, isUpdateVoltage);
  }

  static void propagateVoltage(Wire wire, bool isUpdateVoltage) {
    for (CircuitComponent component in wire.getConnectedComponents) {

      // Connected component is a Switch
      if (component is SwitchClass) {
        if (component.getSwitchStatus) {
          if (component.getLeftBottomWire != wire &&
              component.getLeftBottomWire.getVoltage != wire.getVoltage) {
            updateWireVoltage(component.getLeftBottomWire, [wire],
                wire.getVoltage, wire.getVoltageSourceFDR, isUpdateVoltage);
          } else if (component.getRightUpWire != wire &&
              component.getRightUpWire.getVoltage != wire.getVoltage) {
            updateWireVoltage(component.getRightUpWire, [wire], wire.getVoltage,
                wire.getVoltageSourceFDR, isUpdateVoltage);
          }
        }
      }

      // Connected component is a Transformer
      if (component is Transformer) {
        if (component.getInputWire == wire) {
          Transformer.updateOutputVoltage(component);
        } else if (component.getInputWire != wire) {
          return;
        }
      }

      // Connected component is a SSP
      if (component is SSP) {
        return;
      }

      // Connected component is a SP
      if (component is SP) {
        return;
      }
    }
  }

  // Getters
  double get getVoltage => _voltage;
  List<FDR> get getVoltageSourceFDR => _voltageSourceFDR;
  List<CircuitComponent> get getConnectedComponents => _connectedComponents;
  List<CircuitComponent> get getVoltageComingFromComponents =>
      _voltageComingFromComponents;
  List<(int, int)> get coordinates => _coordinates;
  List<int> get quarterTurns => _quarterTurns;


  // Setters
  set setVoltage(double voltage) {
    _voltage = voltage;
    voltageNotifier.value = voltage;
  }
  set setVoltageComingFromComponents(List<CircuitComponent> components) =>
      _voltageComingFromComponents = components;
  set setConnectedComponents(List<CircuitComponent> components) =>
      _connectedComponents = components;
  set setVoltageSourceFDR(List<FDR> fdr) => _voltageSourceFDR = fdr;
  set setWiresCoordinates(List<(int, int)> coordinates) => _coordinates = coordinates;
  set setQuarterTurns(List<int> value) => _quarterTurns = value;


  @override
  String get getId =>_wireId;

  @override
  List<(int, int)> get getCoordinates => _coordinates;

  @override
  List<int> get getQuarterTurns => _quarterTurns;

}
