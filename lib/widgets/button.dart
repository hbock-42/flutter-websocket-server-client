import 'package:flutter/material.dart';

Widget button(
  String text, {
  Color color = Colors.grey,
  void Function() onPressed,
}) {
  return FlatButton(
    color: color,
    onPressed: onPressed != null ? onPressed : () {},
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}
