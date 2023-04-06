import 'package:flutter/material.dart';

Widget buildText(String text) {
  return Row(
    children: [
      const SizedBox(
        width: 20,
      ),
      Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    ],
  );
}
