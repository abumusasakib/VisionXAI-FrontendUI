import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Image.network('https://via.placeholder.com/150'),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onLongPress: () {
                      print('Long pressed!');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
