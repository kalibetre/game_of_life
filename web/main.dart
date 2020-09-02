import 'dart:html';
import 'lib/game_board.dart';
import 'lib/game_engine.dart';
import 'lib/sample_patterns.dart';

void main() {
  CanvasElement canvas = querySelector('#gameCanvas');
  canvas.width = 1000;
  canvas.height = 500;
  var gameBoard = GameBoard(1000, 500, 5);
  var gameEngine = GameEngine(gameBoard, canvas);

  gameBoard.loadGosperGliderGun();
  window.animationFrame.then(gameEngine.runGame);

  ImageElement playPauseButton = querySelector('#playPauseButton');

  DivElement loadAcronButton = querySelector('#loadAcronButton');
  DivElement loadDieHardButton = querySelector('#loadDieHardButton');
  DivElement loadGosperButton = querySelector('#loadGosperButton');
  DivElement loadInfiniteOneButton = querySelector('#loadInfiniteOneButton');
  DivElement loadInfiniteTwoButton = querySelector('#loadInfiniteTwoButton');
  DivElement loadInfiniteThreeButton = querySelector('#loadInfiniteThreeButton');
  DivElement loadRPentominoButton = querySelector('#loadRPentominoButton');
  DivElement loadSimkinButton = querySelector('#loadSimkinButton');
  DivElement randomizeButton = querySelector('#randomizeButton');

  playPauseButton.onClick.capture((event) {
    gameEngine.playPauseGame();
    if (gameEngine.isGamePaused) {
      playPauseButton.src = 'resources/images/play_button.png';
    } else {
      playPauseButton.src = 'resources/images/pause_button.png';
    }
  });

  loadAcronButton.onClick.capture((event) {
    gameBoard.loadAcorn();
  });
  loadDieHardButton.onClick.capture((event) {
    gameBoard.loadDieHard();
  });
  loadGosperButton.onClick.capture((event) {
    gameBoard.loadGosperGliderGun();
  });
  loadInfiniteOneButton.onClick.capture((event) {
    gameBoard.loadInfiniteGrowthOne();
  });
  loadInfiniteTwoButton.onClick.capture((event) {
    gameBoard.loadInfiniteGrowthTwo();
  });
  loadInfiniteThreeButton.onClick.capture((event) {
    gameBoard.loadInfiniteGrowthThree();
  });
  loadRPentominoButton.onClick.capture((event) {
    gameBoard.loadRPentomino();
  });
  loadSimkinButton.onClick.capture((event) {
    gameBoard.loadSimkinGliderGun();
  });
  randomizeButton.onClick.capture((event) {
    gameBoard.randomizeGameBoard();
  });


  ImageElement loadButton = querySelector('#loadButton');
  TextAreaElement textAreaElement = querySelector('#customPatterTextArea');
  textAreaElement.value = SamplePatterns.gosperGliderGunPattern;

  loadButton.onClick.capture((event) {
    var pattern = textAreaElement.value;
    print(pattern);
    gameBoard.loadPattern(pattern);
  });

}

void playPauseGame() {

}
