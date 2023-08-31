import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/Pixel.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  columnLength,
  (index) => List.generate(
    rowLength,
    (index) => null,
  ),
);

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Piece currentPiece = Piece(type: Tetromino.S);
  @override
  void initState() {
    startGame();
    super.initState();
  }

  startGame() {
    currentPiece.initilizePiece();
    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  gameLoop(frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        checkLanding();
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  checkCollison(Direction direction) {
    for (int postion in currentPiece.postion) {
      int row = (postion / rowLength).floor();
      int col = (postion % rowLength);
      //adjust row and col
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      //check if piece out of bound
      if (row >= columnLength || col < 0 || col >= rowLength) {
        return true;
      }
      //if no collison
      return false;
    }
  }

  void checkLanding() {
    //if going down occupied
    if (checkCollison(Direction.down)) {
      for (int postion in currentPiece.postion) {
        int row = (postion / rowLength).floor();
        int col = (postion % rowLength);

        if (row > 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      //once landed , create the next piece
      createNewPiece();
    }
  }

  createNewPiece() {
    Random random = Random();
    Tetromino randomTetromino =
        Tetromino.values[random.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomTetromino);
    currentPiece.initilizePiece();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowLength,
        ),
        itemCount: rowLength * columnLength,
        itemBuilder: (BuildContext context, int index) {
          int row = (index / rowLength).floor();
          int col = (index % rowLength);
          if (currentPiece.postion.contains(index)) {
            return Pixel(
              color: currentPiece.color,
              child: Text(index.toString()),
            );
          } else if (gameBoard[row][col] != null) {
            final Tetromino? tetrominoType = gameBoard[row][col];
            return Pixel(
              color: tetrominoColors[tetrominoType]!,
              child: Text(index.toString()),
            );
          } else {
            return Pixel(
              color: Colors.grey.shade900,
              child: Text(index.toString()),
            );
          }
        },
      ),
    );
  }
}
