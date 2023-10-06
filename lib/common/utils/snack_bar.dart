import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
    ),
    backgroundColor: Colors.amber,
  ));
}
