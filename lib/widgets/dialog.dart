import 'package:flutter/material.dart';

class OkCancelDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function onTapOk;
  final Function onTapCancel;

  OkCancelDialog({this.title, this.message, this.onTapOk, this.onTapCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(onPressed: onTapCancel, child: Text("Cancel")),
        FlatButton(onPressed: onTapOk, child: Text("Ok"))
      ],
    );
  }
}

class InformationDialog extends StatelessWidget {
  final String title;
  final String message;

  InformationDialog({this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[FlatButton(onPressed: () {}, child: Text("Ok"))],
    );
  }
}
