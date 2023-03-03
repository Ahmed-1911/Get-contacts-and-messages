import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Customloading extends StatelessWidget {
  Customloading({required this.width, required this.color});

  Color color;
  double width;

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: color,
      size: width,
    );
  }
}
