import 'package:flutter/material.dart';
import 'package:scada_simulation_2_0/config.dart'; // Import the configuration file
import 'customComponentsWidgets/fdr_widget.dart';
import 'customComponentsWidgets/sp_widget.dart';
import 'customComponentsWidgets/ssp_widget.dart';
import 'customComponentsWidgets/transformer_widget.dart';
import 'customComponentsWidgets/wire_widget.dart';
import 'customComponentsWidgets/switch_widget.dart';
import 'switch_class.dart';
import 'fdr_class.dart';

class ComponentsBuilder {
  static double scale = 1.0;
  static double baseScale = 1.0;

  static void handleScaleStart(ScaleStartDetails details) {
    baseScale = scale;
  }

  static void handleScaleUpdate(ScaleUpdateDetails details, StateSetter setState) {
    setState(() {
      scale = baseScale * details.scale;
    });
  }

  static Widget createComponent(Widget component, int row, int column) {
    return Positioned(
      left: (column + 1) * columnWidth * scale,
      top: (row + 1) * rowHeight * scale,
      child: component, // Removed redundant Transform.scale()
    );
  }

  static List<Widget> buildComponents(BuildContext context, StateSetter setState) {
    List<Widget> componentWidgets = [];

    // Build wire components
    for (var config in wireConfigs) {
      for (var coord in config['coordinates']) {
        componentWidgets.add(
          createComponent(
            WireWidget(
              wire: config['wire'],
              quarterTurns: coord['quarterTurns'],
              wireImagePath: coord['imagePath'],
            ),
            coord['position'][0],
            coord['position'][1],
          ),
        );
      }
    }

    // Build FDR components
    for (var fdr in fdrList) {
      componentWidgets.add(
        createComponent(
          FDRWidget(
            fdr: fdr,
            toggleFdr: () => setState(() {
              FDR.toggleFDR(fdr, fdr.getConnectedWireID, context);
            }),
            quarterTurns: fdr.getQuarterTurns[0],
          ),
          fdr.getCoordinates[0].$1,
          fdr.getCoordinates[0].$2,
        ),
      );
    }

    // Build switch components
    for (var switchComp in switchList) {
      componentWidgets.add(
        createComponent(
          SwitchWidget(
            switchComponent: switchComp,
            toggleSwitch: () => setState(() {
              SwitchClass.toggleSwitch(switchComp, context);
            }),
            quarterTurns: switchComp.getQuarterTurns[0],
          ),
          switchComp.getCoordinates[0].$1,
          switchComp.getCoordinates[0].$2,
        ),
      );
    }

    // Build transformer components
    for (var transformer in transformerList) {
      componentWidgets.add(
        createComponent(
          TransformerWidget(transformer: transformer),
          transformer.getCoordinates[0].$1,
          transformer.getCoordinates[0].$2,
        ),
      );
    }

    // Build SSP components
    for (var ssp in sspList) {
      componentWidgets.add(
        createComponent(
          SspWidget(
            sspComponent: ssp,
            quarterTurns: ssp.getQuarterTurns[0],
          ),
          ssp.getCoordinates[0].$1,
          ssp.getCoordinates[0].$2,
        ),
      );
    }

    // Build SP components
    for (var sp in spList) {
      componentWidgets.add(
        createComponent(
          SpWidget(
            spComponent: sp,
            quarterTurns: sp.getQuarterTurns[0],
          ),
          sp.getCoordinates[0].$1,
          sp.getCoordinates[0].$2,
        ),
      );
    }

    return componentWidgets;
  }
}


class GridPainter extends CustomPainter {
  final int totalRows;
  final int totalColumns;
  final double scale;

  GridPainter(this.totalRows, this.totalColumns, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 0.5;

    for (int i = 1; i <= totalRows; i++) {
      final y = i * rowHeight * scale;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    for (int j = 1; j <= totalColumns; j++) {
      final x = j * columnWidth * scale;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i <= totalRows; i++) {
      textPainter.text = TextSpan(
        text: '${i-1}',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      );
      textPainter.layout(minWidth: 0, maxWidth: 30);
      textPainter.paint(canvas, Offset(0, (i + 1) * rowHeight * scale - rowHeight / 2));
    }

    for (int j = 0; j <= totalColumns; j++) {
      textPainter.text = TextSpan(
        text: '${j-1}',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      );
      textPainter.layout(minWidth: 0, maxWidth: 30);
      textPainter.paint(canvas, Offset((j + 1) * columnWidth * scale - columnWidth / 2, 0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}