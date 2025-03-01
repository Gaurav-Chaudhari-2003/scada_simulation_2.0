import 'package:flutter/material.dart';
import '../sp_class.dart';

class SpWidget extends StatefulWidget {
  final SP spComponent;
  final int quarterTurns;

  const SpWidget({
    super.key,
    required this.spComponent,
    required this.quarterTurns,
  });

  @override
  _SpWidgetState createState() => _SpWidgetState();
}

class _SpWidgetState extends State<SpWidget> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Tooltip(
        message: 'SP: ${widget.spComponent.getId}\n'
            'Left-Bottom Wire: ${widget.spComponent.getLeftBottomWire.getId} - ${widget.spComponent.getLeftBottomWire.getVoltage}\n'
            'Right-Up Wire: ${widget.spComponent.getRightUpWire.getId} - ${widget.spComponent.getRightUpWire.getVoltage}',
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
                      'assets/sp.png', // Path to the image for SP
                    ),
                  ],
                ),
              ),
            ),
            Text(
              widget.spComponent.getId,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
