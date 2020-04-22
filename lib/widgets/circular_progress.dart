import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  Color color;
  CircularProgress({this.color});

  @override
  Widget build(BuildContext context) {
    if (this.color == null) this.color = Theme.of(context).primaryColor;
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: this.color,
        ),
      ),
    );
  }
}
