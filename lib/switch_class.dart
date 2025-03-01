import 'package:flutter/cupertino.dart';
import 'customComponentsWidgets/custom_alert.dart';
import 'wire_class.dart';
import 'circuit_components_interface.dart';

class SwitchClass extends CircuitComponent {
  final String _switchID;
  bool _switchStatus;
  final Wire _leftBottomWire;
  final Wire _rightUpWire;
  late final List<(int row, int column)> _coordinates;
  late final List<int> _quarterTurns;

  SwitchClass({
    required String switchID,
    required Wire leftBottomWire,
    required Wire rightUpWire,
    required (int row, int column) coordinates,
    required int quarterTurns
  })  : _switchID = switchID,
        _leftBottomWire = leftBottomWire,
        _rightUpWire = rightUpWire,
        _coordinates = [coordinates],
        _quarterTurns = [quarterTurns],
        _switchStatus = false;

  static void toggleSwitch(SwitchClass switchComponent, BuildContext context) {
    switchComponent.toggleSwitchStatus();

    if (switchComponent.getSwitchStatus) {
      if (switchComponent.getLeftBottomWire.getVoltage == 0 &&
          switchComponent.getRightUpWire.getVoltage != 0) {
        Wire.updateWireVoltage(
            switchComponent.getLeftBottomWire,
            [switchComponent.getRightUpWire],
            switchComponent.getRightUpWire.getVoltage,
            switchComponent.getRightUpWire.getVoltageSourceFDR,
            false);
      } else if (switchComponent.getLeftBottomWire.getVoltage != 0 &&
          switchComponent.getRightUpWire.getVoltage == 0) {
        Wire.updateWireVoltage(
            switchComponent.getRightUpWire,
            [switchComponent.getLeftBottomWire],
            switchComponent.getLeftBottomWire.getVoltage,
            switchComponent.getLeftBottomWire.getVoltageSourceFDR,
            false);
      } else if (switchComponent.getLeftBottomWire.getVoltage != 0 &&
          switchComponent.getRightUpWire.getVoltage != 0) {
        if (switchComponent.getLeftBottomWire.getVoltageSourceFDR[0] !=
            switchComponent.getRightUpWire.getVoltageSourceFDR[0]) {
          switchComponent.toggleSwitchStatus(); // Revert toggle status
          CustomAlert.showAlert(
            context,
            "Short Circuit Detected!",
            "First wire : ${switchComponent.getLeftBottomWire.getId} - ${switchComponent.getLeftBottomWire.getVoltageSourceFDR[0].getId}\nSecond Wire: ${switchComponent.getRightUpWire.getId} - ${switchComponent.getRightUpWire.getVoltageSourceFDR[0].getId}",
          );
        }
      }
    } else {
      if (switchComponent.getLeftBottomWire.getVoltageComingFromComponents
          .contains(switchComponent.getRightUpWire)) {
        Wire.updateWireVoltage(
            switchComponent.getLeftBottomWire,
            [switchComponent.getRightUpWire],
            0,
            [switchComponent.getLeftBottomWire.getVoltageSourceFDR[0]],
            false);
        Wire.updateWireVoltage(
            switchComponent
                .getRightUpWire.getVoltageSourceFDR[0].getConnectedWireID,
            [switchComponent.getRightUpWire.getVoltageSourceFDR[0]],
            switchComponent.getRightUpWire.getVoltageSourceFDR[0].getVoltage,
            [switchComponent.getRightUpWire.getVoltageSourceFDR[0]],
            false);
      } else if (switchComponent.getRightUpWire.getVoltageComingFromComponents
          .contains(switchComponent.getLeftBottomWire)) {
        Wire.updateWireVoltage(
            switchComponent.getRightUpWire,
            [switchComponent.getLeftBottomWire],
            0,
            [switchComponent.getRightUpWire.getVoltageSourceFDR[0]],
            false);
        Wire.updateWireVoltage(
            switchComponent
                .getLeftBottomWire.getVoltageSourceFDR[0].getConnectedWireID,
            [switchComponent.getLeftBottomWire.getVoltageSourceFDR[0]],
            switchComponent.getLeftBottomWire.getVoltageSourceFDR[0].getVoltage,
            [switchComponent.getLeftBottomWire.getVoltageSourceFDR[0]],
            false);
      }
    }
  }

  void toggleSwitchStatus() {
    _switchStatus = !_switchStatus;
  }

  bool get getSwitchStatus => _switchStatus;
  Wire get getLeftBottomWire => _leftBottomWire;
  Wire get getRightUpWire => _rightUpWire;

  set setSwitchStatus(bool status) => _switchStatus = status;

  @override
  String get getId => _switchID;
  @override
  List<(int, int)> get getCoordinates => _coordinates;
  @override
  List<int> get getQuarterTurns => _quarterTurns;
}
