import 'package:flutter/material.dart';

void showInSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: new Text(message)));
}
