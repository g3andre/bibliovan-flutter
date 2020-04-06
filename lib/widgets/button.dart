import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  void Function() _onPressed;
  String _label;

  Button(this._label, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 45),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: RaisedButton(
        onPressed: this._onPressed,
        child: Text(
          this._label,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
