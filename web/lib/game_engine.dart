import 'dart:html';
import 'game_board.dart';

class GameEngine {
  final _colors = ['white', 'black'];
  final GameBoard _gameBoard;
  final CanvasElement _canvasElement;
  final int _minRenderInterval = 100;
  num _lastRenderTimeStamp = 0;
  var _isGamePaused = false;
  GameEngine(this._gameBoard, this._canvasElement);

  bool get isGamePaused => _isGamePaused;
  void playPauseGame() => _isGamePaused = !_isGamePaused;

  void runGame(num timeStamp) {
    if (_lastRenderTimeStamp == 0) {
      _lastRenderTimeStamp = timeStamp;
    }

    if (timeStamp - _lastRenderTimeStamp >= _minRenderInterval) {
      if (!_isGamePaused) {
        _gameBoard.nextPattern();
        renderGame();
      }
      _lastRenderTimeStamp = timeStamp;
    }
    window.animationFrame.then(runGame);
  }

  void renderGame() {
    CanvasRenderingContext2D c2d;
    c2d = _canvasElement.getContext('2d');

    for (var row in _gameBoard.cells) {
      for (var cell in row) {
        c2d
          ..fillStyle = cell.isAlive ? _colors[0] : _colors[1]
          ..fillRect(cell.locationX, cell.locationY, cell.size, cell.size);
      }
    }
  }
}
