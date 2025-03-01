import 'package:flutter/material.dart';
import 'package:scada_simulation_2_0/ssp_class.dart';

class SspWidget extends StatefulWidget {
  final SSP sspComponent;
  final int quarterTurns;

  const SspWidget({
    super.key,
    required this.sspComponent,
    required this.quarterTurns,
  });

  @override
  _SspWidgetState createState() => _SspWidgetState();
}

class _SspWidgetState extends State<SspWidget> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Tooltip(
        message: 'SSP: ${widget.sspComponent.getId}\n'
            'Left-Bottom Wire: ${widget.sspComponent.getLeftBottomWire.getId} - ${widget.sspComponent.getLeftBottomWire.getVoltage}\n'
            'Right-Up Wire: ${widget.sspComponent.getRightUpWire.getId} - ${widget.sspComponent.getRightUpWire.getVoltage}',
        showDuration: const Duration(seconds: 5),
        waitDuration: Duration(seconds: 1),
        child: Column(
          children: [
            RotatedBox(
              quarterTurns: widget.quarterTurns,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/ssp.png', // Path to the image for SSP
                    ),
                  ],
                ),
              ),
            ),
            Text(
              widget.sspComponent.getId,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
