import 'package:flutter/material.dart';
import '../transformer_class.dart';

class TransformerWidget extends StatefulWidget {
  final Transformer transformer;

  const TransformerWidget({super.key, required this.transformer});

  @override
  _TransformerWidgetState createState() => _TransformerWidgetState();
}

class _TransformerWidgetState extends State<TransformerWidget> {
  void _showVoltageAdjustmentDialog(BuildContext context) {
    double tempSliderValue = widget.transformer.getFactor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Adjust Output Voltage'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Output Voltage: ${(widget.transformer.getInputVoltage * tempSliderValue).toStringAsFixed(1)} V'),
                  Slider(
                    value: tempSliderValue,
                    min: 0,
                    max: 1,
                    divisions: 500,
                    label:
                        (widget.transformer.getInputVoltage * tempSliderValue)
                            .toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        tempSliderValue = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.transformer.adjustOutputVoltage(tempSliderValue);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showVoltageAdjustmentDialog(context),
      child: Tooltip(
        message: 'Transformer ID: ${widget.transformer.id}\n'
            'Input Wire: ${widget.transformer.getInputWire.getId}\n'
            'Input Voltage: ${widget.transformer.getInputVoltage} V\n'
            'Output Wire: ${widget.transformer.getOutputWire.getId}\n'
            'Output Voltage: ${widget.transformer.getOutputVoltage.toStringAsFixed(1)} V',
        child: Image.asset(
          'assets/transformer.png', // Image for transformer
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
