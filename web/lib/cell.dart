class Cell {
  final int locationX;
  final int locationY;
  final int size;
  bool isAlive;

  Cell(row, col, this.size, [this.isAlive = false]) :
        locationX = col * size,
        locationY = row * size;

  Cell.deadCell() :
        locationX =  0,
        locationY =  0,
        size = 0, isAlive = false;

  Cell.fromCell(Cell cell) :
        locationX = cell.locationX,
        locationY = cell.locationY,
        isAlive = cell.isAlive,
        size = cell.size;

  @override
  String toString() {
    return '{ ($locationX, $locationY) : $isAlive }';
  }
}
