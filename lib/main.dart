import 'package:flutter/material.dart';
import 'package:scada_simulation_2_0/componentsBuilder.dart';
import 'package:scada_simulation_2_0/config.dart';

class CircuitSimulation extends StatefulWidget {
  const CircuitSimulation({super.key});

  @override
  _CircuitSimulationState createState() => _CircuitSimulationState();
}

class _CircuitSimulationState extends State<CircuitSimulation> {
  bool _isSidebarExpanded = true; // Sidebar state

  // Define sidebar menu items dynamically
  final List<Map<String, dynamic>> sidebarItems = [
    {'label': "Route 1", 'onPressed': () {}},
    {'label': "Route 2", 'onPressed': () {}},
    {'label': "Route 3", 'onPressed': () {}},
    {'label': "Route N", 'onPressed': () {}},
  ];

  final List<Map<String, dynamic>> componentItems = [
    {'label': "FDR OFF", 'color': Colors.red, 'icon': 'assets/fdr.png'},
    {'label': "FDR ON", 'color': Colors.green, 'icon': 'assets/fdr.png'},
    {'label': "Switch OPEN", 'color': Colors.red, 'icon': 'assets/switch.png'},
    {'label': "Switch CLOSED", 'color': Colors.green, 'icon': 'assets/switch.png'},
    {'label': "Wire INACTIVE", 'color': Colors.red, 'icon': 'assets/wire_1.png'},
    {'label': "Wire ACTIVE", 'color': Colors.green, 'icon': 'assets/wire_1.png'},
    {'label': "SP", 'color': Colors.green, 'icon': 'assets/sp.png'},
    {'label': "SSP", 'color': Colors.green, 'icon': 'assets/ssp.png'},
    {'label': "Transformer", 'color': Colors.green, 'icon': 'assets/transformer.png'},
  ];


  @override
  void initState() {
    super.initState();
    initializeComponents();
  }

  @override
  Widget build(BuildContext context) {
    const int totalColumns = 100;
    const int totalRows = 100;

    return Scaffold(
      drawer: Padding(
        padding: const EdgeInsets.only(top: 58.0),
        child: Container(
          width: 500,
          color: Colors.black,
          child: Column(
            children: [
              // Toggle Button
              if (_isSidebarExpanded) ...[
                const SizedBox(height: 10),
                const Text(
                  "Menu",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 20),

                // Route Chooser using ListView.builder
                Container(
                  height: 150,
                  color: Colors.black,
                  child: ListView.builder(
                    itemCount: sidebarItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: sidebarItems[index]['onPressed'],
                          child: Text(
                            sidebarItems[index]['label'],
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(color: Colors.white),

                // Components Info
                const Text(
                  "Components Info",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 10),

                // Components List using ListView.builder
                Expanded(
                  child: ListView.builder(
                    itemCount: componentItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 50),
                            Container(
                              color: componentItems[index]['color'],
                              height: 40,
                              width: 40,
                              child: Image.asset(componentItems[index]['icon']),
                            ),
                            const SizedBox(width: 30),
                            Text(
                              componentItems[index]['label'],
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      appBar: AppBar(),
      body: Stack(
        children: [
          GestureDetector(
            onScaleStart: ComponentsBuilder.handleScaleStart,
            onScaleUpdate: (details) =>
                ComponentsBuilder.handleScaleUpdate(details, setState),
            child: Container(
              color: Colors.black,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: columnWidth *
                        (totalColumns + 1) *
                        ComponentsBuilder.scale,
                    height:
                        rowHeight * (totalRows + 1) * ComponentsBuilder.scale,
                    child: Stack(
                      children: <Widget>[
                        CustomPaint(
                          size: Size(
                            columnWidth * (totalColumns + 1) * ComponentsBuilder.scale,
                            rowHeight * (totalRows + 1) * ComponentsBuilder.scale,
                          ),
                          painter: GridPainter(totalRows, totalColumns, ComponentsBuilder.scale),
                        ),
                        Stack(
                          children: ComponentsBuilder.buildComponents(
                              context, setState),
                        ),

                        Positioned(
                          left: columnWidth * 5, // Adjust to position in grid
                          top: rowHeight * 2, // Adjust to position in grid
                          child: Container(
                              width: columnWidth * 6, // 4 columns wide
                              height: rowHeight * 2, // 2 rows high
                              alignment: Alignment.center,
                              // color: Colors.blue.withOpacity(00.5), // Optional background color
                              child: Column(
                                children: [
                                  const Text(
                                    "CNDB CSS",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    "Chandurbazar Transaction Section",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Sidebar with animation
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CircuitSimulation(),
  ));
}
