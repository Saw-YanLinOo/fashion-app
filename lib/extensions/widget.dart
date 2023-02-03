import 'package:flutter/material.dart';

extension UtilWidget on Widget {
  toNextScreen(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }
}
