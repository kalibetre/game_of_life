import 'dart:math';
import 'cell.dart';
import 'pair.dart';
import 'sample_patterns.dart';

class GameBoard {
  List<List<Cell>> cells;
  int _numberOfRows = 0;
  int _numberOfCols = 0;
  final _randomGenerator = Random();

  GameBoard(width, height, cellSize) {
    _numberOfCols = width ~/ cellSize;
    _numberOfRows = height ~/ cellSize;

    cells = <List<Cell>>[];
    for (var row = 0; row < _numberOfRows; ++row) {
      cells.add(<Cell>[]);
      for (var col = 0; col < _numberOfCols; ++col) {
        cells[row].add(Cell(row, col, cellSize));
      }
    }
  }

  void randomizeGameBoard() {
    for (var row = 0; row < _numberOfRows; ++row) {
      for (var col = 0; col < _numberOfCols; ++col) {
        if(_randomGenerator.nextBool()) {
          cells[row][col].isAlive = _randomGenerator.nextBool();
        }
      }
    }
  }

  void nextPattern() {
    var previousCells = <List<Cell>>[];
    for (var row = 0; row < _numberOfRows; ++row) {
      previousCells.add(<Cell>[]);
      for (var col = 0; col < _numberOfCols; ++col) {
        previousCells[row].add(Cell.fromCell(cells[row][col]));
      }
    }

    for (var row = 0; row < _numberOfRows; ++row) {
      for (var col = 0; col < _numberOfCols; ++col) {

        var neighbors = [];
        neighbors.add( row >= 1 && col >= 1 ? previousCells[row - 1][col - 1] : Cell.deadCell() );
        neighbors.add( col >= 1 && col >= 1 ? previousCells[row][col - 1] : Cell.deadCell() );
        neighbors.add( row < _numberOfRows - 1 && col >= 1 ? previousCells[row + 1][col - 1] : Cell.deadCell() );

        neighbors.add( row >= 1 ? previousCells[row - 1][col] : Cell.deadCell() );
        neighbors.add( row < _numberOfRows - 1 ? previousCells[row + 1][col] : Cell.deadCell() );

        neighbors.add( row >= 1 && col < _numberOfCols - 1 ? previousCells[row - 1][col + 1] : Cell.deadCell() );
        neighbors.add( col < _numberOfCols - 1 ? previousCells[row][col + 1] : Cell.deadCell() );
        neighbors.add( row < _numberOfRows - 1 && col < _numberOfCols - 1 ? previousCells[row + 1][col + 1] : Cell.deadCell() );

        var liveNeighbors = neighbors.where((cell) => cell.isAlive).length;

        // Rule 1 or Rule 3
        if (previousCells[row][col].isAlive && (liveNeighbors < 2 || liveNeighbors > 3)) {
          cells[row][col].isAlive = false;
        }
        // Rule 4
        if (!previousCells[row][col].isAlive && liveNeighbors == 3) {
          cells[row][col].isAlive = true;
        }
      }
    }
  }

  void loadAcorn() => loadPattern(SamplePatterns.acronPattern);

  void loadDieHard() => loadPattern(SamplePatterns.dieHardPattern);

  void loadGosperGliderGun() =>
      loadPattern(SamplePatterns.gosperGliderGunPattern);

  void loadInfiniteGrowthOne() =>
      loadPattern(SamplePatterns.infiniteGrowthOnePattern);

  void loadInfiniteGrowthTwo() =>
      loadPattern(SamplePatterns.infiniteGrowthTwoPattern);

  void loadInfiniteGrowthThree() =>
      loadPattern(SamplePatterns.infiniteGrowthThreePattern);

  void loadRPentomino() => loadPattern(SamplePatterns.rPentominoPattern);

  void loadSimkinGliderGun() =>
      loadPattern(SamplePatterns.simkinGliderGunPattern);

  void clearBoard() {
    for (var row = 0; row < _numberOfRows; ++row) {
      for (var col = 0; col < _numberOfCols; ++col)  {
        cells[row][col].isAlive = false;
      }
    }
  }

  void loadPattern(String patternString) {
    clearBoard();
    var pattern = getPatternFromString(patternString);
    for(var pair in pattern) {
      cells[pair.first][pair.second].isAlive = true;
    }
  }

  List<Pair<int,int>> getPatternFromString(String patternString) {
    var pattern = <Pair<int,int>>[];
    var lines = patternString.split('\n').toList();

    var centerRow = _numberOfRows ~/ 2;
    var centerCol = _numberOfCols ~/ 2;
    var rowOffset = centerRow - lines.length ~/ 2;
    var colOffset = centerCol - lines[0].length ~/ 2;

    for(var row = 0; row < lines.length; ++row) {
      lines[row] = lines[row].trim();
      for(var col = 0; col < lines[row].length; ++col) {
        if (lines[row][col] == '#') {
          pattern.add(Pair(row + rowOffset, col + colOffset));
        }
      }
    }

    return pattern;
  }
}

