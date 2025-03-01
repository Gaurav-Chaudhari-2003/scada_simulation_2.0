// Create an interface for all components

abstract class CircuitComponent {
  List<(int row, int column)> get getCoordinates;
  List<int> get getQuarterTurns;
  String get getId;
}
