import 'package:flutter/material.dart';

enum Tetromino { L, J, I, O, S, Z, T }

enum Direction { left, right, down }

const int rowLength = 10;
const int columnLength = 15;
const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.I: Colors.amber,
  Tetromino.J: Colors.blue,
  Tetromino.L: Colors.green,
  Tetromino.O: Colors.red,
  Tetromino.S: Colors.purple,
  Tetromino.T: Colors.pink,
  Tetromino.Z: Colors.yellow
};
