import 'package:flutter/material.dart';

class RouteManager {
  static push(BuildContext context, route) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => route));
  }
}
