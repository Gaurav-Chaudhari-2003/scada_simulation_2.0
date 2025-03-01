import 'package:flutter/material.dart';
import '/wire_class.dart';

class WireWidget extends StatefulWidget {
  final Wire wire;
  final int quarterTurns;
  final String wireImagePath;

  const WireWidget(
      {super.key,
      required this.wire,
      required this.quarterTurns,
      required this.wireImagePath});

  @override
  _WireWidgetState createState() => _WireWidgetState();
}

class _WireWidgetState extends State<WireWidget> {
  Color containerColor = Colors.red;

  @override
  void initState() {
    super.initState();
    // Listen to voltage changes
    widget.wire.voltageNotifier.addListener(updateColor);
    updateColor(); // Set initial color based on initial voltage
  }

  void updateColor() {
    setState(() {
      containerColor = widget.wire.getVoltage != 0 ? Colors.green : Colors.red;
    });
  }

  @override
  void dispose() {
    widget.wire.voltageNotifier.removeListener(updateColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      color: containerColor,
      child: Tooltip(
        message: 'Wire: ${widget.wire.getId}\n'
            'Voltage: ${widget.wire.getVoltage != 0 ? '${widget.wire.getVoltage}V' : 'N/A'}\n'
            'Connected Components: ${widget.wire.getConnectedComponents.isNotEmpty ? widget.wire.getConnectedComponents.map((c) => c.getId).join(', ') : 'None'}\n'
            'Voltage Source FDR: ${(widget.wire.getVoltageSourceFDR.isNotEmpty) ? widget.wire.getVoltageSourceFDR[0].getId : "None"}',
        showDuration: const Duration(seconds: 5),
        waitDuration: Duration(seconds: 1),
        child: RotatedBox(
          quarterTurns: widget.quarterTurns,
          child: Image.asset(
            widget.wireImagePath, // Path to the image for Wire
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
