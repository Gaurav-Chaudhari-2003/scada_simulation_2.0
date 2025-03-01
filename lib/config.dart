// config.dart
import 'package:scada_simulation_2_0/sp_class.dart';
import 'package:scada_simulation_2_0/ssp_class.dart';
import 'package:scada_simulation_2_0/transformer_class.dart';

import 'fdr_class.dart';
import 'wire_class.dart';
import 'switch_class.dart';

// Constants
const double columnWidth = 50.0;
const double rowHeight = 50.0;
const String wire1ImagePath = 'assets/wire_1.png';
const String wire2ImagePath = 'assets/wire_2.png';
const String wire3ImagePath = 'assets/wire_3.png';
const String wire4ImagePath = 'assets/wire_4.png';

// Components
List<FDR> fdrList = List.empty(growable: true);
List<SwitchClass> switchList = List.empty(growable: true);
List<Transformer> transformerList = List.empty(growable: true);
List<SSP> sspList = List.empty(growable: true);
List<SP> spList = List.empty(growable: true);
late List<Wire> wire;
const int totalWires = 18;
late List<Map<String, dynamic>> wireConfigs, switchConfigs, fdrConfigs, transformerConfigs, sspConfigs, spConfigs;

void initializeComponents() {
  // Initialize wires
  wire = List.generate(totalWires, (index) => Wire(id: 'Wire$index', connectedComponents: []));

  fdrList.add(FDR(id: 'FDR0', voltage: 0.0, connectedWire: wire[0], coordinates: (-2, -2), quarterTurns: 0));
  fdrList.add(FDR(id: 'FDR1', voltage: 130.0, connectedWire: wire[7], coordinates: (15, 2), quarterTurns: 0));
  fdrList.add(FDR(id: 'FDR2', voltage: 100.0, connectedWire: wire[14], coordinates: (15, 10), quarterTurns: 0));

  switchList.add(SwitchClass(switchID: 'Switch0', leftBottomWire: wire[0], rightUpWire: wire[0], coordinates: (-2, -2), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch1', leftBottomWire: wire[3], rightUpWire: wire[1], coordinates: (5, 2), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch2', leftBottomWire: wire[4], rightUpWire: wire[3], coordinates: (7, 2), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch3', leftBottomWire: wire[5], rightUpWire: wire[4], coordinates: (9, 2), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch4', leftBottomWire: wire[7], rightUpWire: wire[6], coordinates: (13, 2), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch5', leftBottomWire: wire[3], rightUpWire: wire[2], coordinates: (5, 4), quarterTurns: 0));
  switchList.add(SwitchClass(switchID: 'Switch6', leftBottomWire: wire[3], rightUpWire: wire[8], coordinates: (6, 6), quarterTurns: 0));
  switchList.add(SwitchClass(switchID: 'Switch7', leftBottomWire: wire[4], rightUpWire: wire[11], coordinates: (8, 6), quarterTurns: 0));
  switchList.add(SwitchClass(switchID: 'Switch8', leftBottomWire: wire[8], rightUpWire: wire[9], coordinates: (5, 8), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch9', leftBottomWire: wire[8], rightUpWire: wire[10], coordinates: (5, 10), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch10', leftBottomWire: wire[11], rightUpWire: wire[8], coordinates: (7, 10), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch11', leftBottomWire: wire[12], rightUpWire: wire[11], coordinates: (9, 10), quarterTurns: 1));
  switchList.add(SwitchClass(switchID: 'Switch12', leftBottomWire: wire[14], rightUpWire: wire[13], coordinates: (13, 10), quarterTurns: 1));

  transformerList.add(Transformer(id: 'Transformer0', inputWire: wire[0], outputWire: wire[0], coordinates: (-2, -2), quarterTurns: 0));
  transformerList.add(Transformer(id: 'Transformer1', inputWire: wire[6], outputWire: wire[5], coordinates: (11, 2), quarterTurns: 0));
  transformerList.add(Transformer(id: 'Transformer2', inputWire: wire[13], outputWire: wire[12], coordinates: (11, 10), quarterTurns: 0));

  sspList.add(SSP(sspID: 'SSP0', leftBottomWire: wire[0], rightUpWire: wire[0], coordinates: (-2, -2), quarterTurns: 0));
  sspList.add(SSP(sspID: 'SSP1', leftBottomWire: wire[9], rightUpWire: wire[9], coordinates: (4, 13), quarterTurns: 0));

  spList.add(SP(sspID: 'SP0', leftBottomWire: wire[0], rightUpWire: wire[0], coordinates: (-2, -2), quarterTurns: 0));
  spList.add(SP(sspID: 'SP1', leftBottomWire: wire[2], rightUpWire: wire[9], coordinates: (4, 6), quarterTurns: 0));

  wire[1].setConnectedComponents = [switchList[1].getLeftBottomWire, switchList[1]];
  wire[2].setConnectedComponents = [switchList[5].getLeftBottomWire, switchList[5]];
  wire[3].setConnectedComponents = [
    switchList[1].getRightUpWire,
    switchList[2].getLeftBottomWire,
    switchList[5].getRightUpWire,
    switchList[6].getRightUpWire,
    switchList[1], switchList[2], switchList[5], switchList[6]
  ];
  wire[4].setConnectedComponents = [
    switchList[2].getRightUpWire,
    switchList[3].getLeftBottomWire,
    switchList[7].getRightUpWire,
    switchList[2], switchList[3], switchList[7]
  ];
  wire[5].setConnectedComponents = [
    switchList[3].getRightUpWire,
    switchList[3],
    transformerList[1]
  ];
  wire[6].setConnectedComponents = [
    switchList[4].getLeftBottomWire,
    switchList[4],
    transformerList[1]
  ];
  wire[7].setConnectedComponents = [
    switchList[4].getRightUpWire,
    fdrList[1], switchList[4]
  ];
  wire[8].setConnectedComponents = [
    switchList[6].getLeftBottomWire,
    switchList[8].getRightUpWire,
    switchList[9].getRightUpWire,
    switchList[10].getLeftBottomWire,
    switchList[6], switchList[8], switchList[9], switchList[10]];
  wire[9].setConnectedComponents = [
    switchList[8].getLeftBottomWire,
    switchList[8], sspList[1].getRightUpWire
  ];
  wire[10].setConnectedComponents = [
    switchList[9].getLeftBottomWire,
    switchList[9]
  ];
  wire[11].setConnectedComponents = [
    switchList[7].getLeftBottomWire,
    switchList[10].getRightUpWire,
    switchList[11].getLeftBottomWire,
    switchList[7], switchList[10], switchList[11]
  ];
  wire[12].setConnectedComponents = [
    switchList[11].getRightUpWire,
    transformerList[2].getInputWire,
    switchList[11], transformerList[2]
  ];
  wire[13].setConnectedComponents = [
    switchList[12].getLeftBottomWire,
    transformerList[2].getOutputWire,
    switchList[12], transformerList[2]
  ];
  wire[14].setConnectedComponents = [
    switchList[12].getRightUpWire,
    fdrList[2], switchList[12]
  ];

  // Function to build wires using nested loops with specific image paths and rotations for each coordinate
  wireConfigs = [
    {
      'wire': wire[1],
      'coordinates': [
        {
          'position': [3, 0],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [3, 1],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [3, 2],
          'imagePath': wire2ImagePath,
          'quarterTurns': 2
        },
        {
          'position': [4, 2],
          'imagePath': wire4ImagePath,
          'quarterTurns': 1
        }
      ]
    },
    {
      'wire': wire[2],
      'coordinates': [
        {
          'position': [4, 0],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [4, 1],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [4, 3],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [4, 4],
          'imagePath': wire3ImagePath,
          'quarterTurns': 2
        },
        {
          'position': [4, 5],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
      ]
    },
    {
      'wire': wire[3],
      'coordinates': [
        {
          'position': [6, 2],
          'imagePath': wire3ImagePath,
          'quarterTurns': 1
        },
        {
          'position': [6, 3],
          'imagePath': wire1ImagePath,
          'quarterTurns': 2
        },
        {
          'position': [6, 4],
          'imagePath': wire3ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [6, 5],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        }
      ]
    },
    {
      'wire': wire[4],
      'coordinates': [
        {
          'position': [8, 2],
          'imagePath': wire3ImagePath,
          'quarterTurns': 1
        },
        {
          'position': [8, 3],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [8, 4],
          'imagePath': wire1ImagePath,
          'quarterTurns': 2
        },
        {
          'position': [8, 5],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        }
      ]
    },
    {
      'wire': wire[5],
      'coordinates': [
        {
          'position': [10, 2],
          'imagePath': wire1ImagePath,
          'quarterTurns': 1
        }
      ]
    },
    {
      'wire': wire[6],
      'coordinates': [
        {
          'position': [12, 2],
          'imagePath': wire1ImagePath,
          'quarterTurns': 1
        }
      ]
    },
    {
      'wire': wire[7],
      'coordinates': [
        {
          'position': [14, 2],
          'imagePath': wire1ImagePath,
          'quarterTurns': 1
        }
      ]
    },
    {
      'wire': wire[8],
      'coordinates': [
        {
          'position': [6, 7],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [6, 8],
          'imagePath': wire3ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [6, 9],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [6, 10],
          'imagePath': wire3ImagePath,
          'quarterTurns': 3
        }
      ]
    },
    {
      'wire': wire[9],
      'coordinates' : [
        {
          'position': [4, 7],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [4, 8],
          'imagePath': wire3ImagePath,
          'quarterTurns': 2
        },
        {
          'position': [4, 9],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [4, 11],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [4, 12],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
      ]
    },
    {
      'wire': wire[10],
      'coordinates' : [
        {
          'position': [4, 10],
          'imagePath': wire4ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [3, 10],
          'imagePath': wire2ImagePath,
          'quarterTurns': 1
        },
        {
          'position': [3, 11],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [3, 12],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
      ]
    },
    {
      'wire': wire[11],
      'coordinates' : [
        {
          'position': [8, 7],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [8, 8],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [8, 9],
          'imagePath': wire1ImagePath,
          'quarterTurns': 0
        },
        {
          'position': [8, 10],
          'imagePath': wire3ImagePath,
          'quarterTurns': 3
        },
      ]
    },
    {
      'wire': wire[12],
      'coordinates' : [
        {
          'position': [10, 10],
          'imagePath': wire1ImagePath,
          'quarterTurns': 1
        },
      ]
    },
    {
      'wire': wire[13],
      'coordinates' : [
        {
          'position': [12, 10],
          'imagePath': wire1ImagePath,
          'quarterTurns': 1
        },
      ]
    },
    {
      'wire': wire[14],
      'coordinates' : [
        {
          'position': [14, 10],
          'imagePath': wire1ImagePath,
          'quarterTurns': 1
        },
      ]
    }
  ];
}