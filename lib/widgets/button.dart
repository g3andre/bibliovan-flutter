import 'package:bibliovan/widgets/circular_progress.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  void Function() onPressed;
  String label;
  bool isBusy;

  Button({this.label, this.onPressed, this.isBusy = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 45),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: RaisedButton(
        onPressed: isBusy ? null : this.onPressed,
        child: isBusy
            ? CircularProgress()
            : Text(
                this.label,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
