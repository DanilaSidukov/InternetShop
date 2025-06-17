
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double height;
  final double width;

  const Loader({
  this.height = 30.0,
  this.width = 30.0,
  super.key
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
