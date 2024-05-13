import 'package:flutter/material.dart';

Widget changeStyle(String title, String value) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.black),
      children: [
        TextSpan(
            text: '$title : ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        TextSpan(text: value, style: const TextStyle(fontSize: 24)),
      ],
    ),
  );
}