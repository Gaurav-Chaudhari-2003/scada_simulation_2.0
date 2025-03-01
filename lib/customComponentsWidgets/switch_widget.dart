import 'package:flutter/material.dart';
import '/switch_class.dart';
import 'custom_alert.dart';

class SwitchWidget extends StatefulWidget {
  final SwitchClass switchComponent;
  final Function() toggleSwitch;
  final int quarterTurns;

  const SwitchWidget({
    super.key,
    required this.switchComponent,
    required this.toggleSwitch,
    required this.quarterTurns,
  });

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late int _quarterTurns;

  @override
  void initState() {
    super.initState();
    _quarterTurns = widget.quarterTurns;
  }

  void _onToggle() {
    // Check if the short circuit is detected
    if (!widget.switchComponent.getSwitchStatus) {
      bool isShortCircuit = _checkForShortCircuit();
      if (isShortCircuit) {
        widget.switchComponent.setSwitchStatus =
            !widget.switchComponent.getSwitchStatus;
        return; // Prevent the switch from rotating
      }
    }

    // Proceed with toggling and rotating if no short circuit
    setState(() {
      widget.toggleSwitch();
      _quarterTurns = (_quarterTurns + 1) % 4; // Rotate by 90 degrees
    });
  }

  bool _checkForShortCircuit() {
    if (widget.switchComponent.getLeftBottomWire.getVoltage != 0 &&
        widget.switchComponent.getRightUpWire.getVoltage != 0) {
      if (widget.switchComponent.getLeftBottomWire.getVoltageSourceFDR[0] !=
          widget.switchComponent.getRightUpWire.getVoltageSourceFDR[0]) {
        widget.switchComponent.toggleSwitchStatus(); // Revert toggle status
        CustomAlert.showAlert(
          context,
          "Short Circuit Detected!",
          "First wire : ${widget.switchComponent.getLeftBottomWire.getId} - ${widget.switchComponent.getLeftBottomWire.getVoltageSourceFDR[0].getId}\nSecond Wire: ${widget.switchComponent.getRightUpWire.getId} - ${widget.switchComponent.getRightUpWire.getVoltageSourceFDR[0].getId}",
        );
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onToggle,
      child: Tooltip(
        message: 'Switch: ${widget.switchComponent.getId}\n'
            'Status: ${widget.switchComponent.getSwitchStatus ? 'CLOSED' : 'OPEN'}\n'
            'Left-Bottom Wire: ${widget.switchComponent.getLeftBottomWire.getId} - ${widget.switchComponent.getLeftBottomWire.getVoltage}\n'
            'Right-Up Wire: ${widget.switchComponent.getRightUpWire.getId} - ${widget.switchComponent.getRightUpWire.getVoltage}',
        showDuration: const Duration(seconds: 5),
        waitDuration: Duration(seconds: 1),
        child: Column(
          children: [
            RotatedBox(
              quarterTurns: _quarterTurns,
              child: Container(
                color: widget.switchComponent.getSwitchStatus
                    ? Colors.green
                    : Colors.red,
                width: 50,
                height: 50,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/switch.png', // Path to the image for Switch
                    ),
                  ],
                ),
              ),
            ),
            Text(
              widget.switchComponent.getId,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
