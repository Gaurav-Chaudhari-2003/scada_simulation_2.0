import 'package:flutter/material.dart';
import '/fdr_class.dart';

class FDRWidget extends StatelessWidget {
  final FDR fdr;
  final Function() toggleFdr;
  final int quarterTurns;

  const FDRWidget({
    super.key,
    required this.fdr,
    required this.toggleFdr,
    required this.quarterTurns,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleFdr,
      child: Tooltip(
        message: 'FDR: ${fdr.getId}\n'
            'Voltage: ${fdr.getVoltage}V\n'
            'Status: ${fdr.getStatus ? 'ON' : 'OFF'}\n'
            'Connected Wire: ${fdr.getConnectedWireID.getId}',
        showDuration: const Duration(seconds: 5),
        waitDuration: Duration(seconds: 1),
        child: Column(
          children: [
            RotatedBox(
              quarterTurns: quarterTurns,
              child: Container(
                color: fdr.getStatus ? Colors.green : Colors.red,
                width: 50,
                height: 50,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/fdr.png', // Path to the image for FDR
                    ),
                  ],
                ),
              ),
            ),
            Text(
              fdr.getId,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
