// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tetris/values.dart';

class Piece {
  Tetromino type;
  Color get color => tetrominoColors[type] ?? Colors.yellow;

  Piece({
    required this.type,
  });

  List<int> postion = [];

  void initilizePiece() {
    switch (type) {
      case Tetromino.I:
        postion = [-4, -5, -6, -7];
        break;
      case Tetromino.J:
        postion = [-25, -15, -5, -6];
        break;
      case Tetromino.L:
        postion = [-26, -16, -6, -5];
        break;
      case Tetromino.O:
        postion = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        postion = [-15, -14, -5, -6];
        break;
      case Tetromino.T:
        postion = [-26, -16, -6, -15];
        break;
      case Tetromino.Z:
        postion = [-17, -16, -6, -5];
        break;
      default:
    }
  }

  movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < postion.length; i++) {
          postion[i] += rowLength;
        }
      case Direction.left:
        for (int i = 0; i < postion.length; i++) {
          postion[i] -= 1;
        }
      case Direction.right:
        for (int i = 0; i < postion.length; i++) {
          postion[i] += 1;
        }

      default:
        break;
    }
  }
}
