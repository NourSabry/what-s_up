// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:whats_up/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback function;

    const CustomButton({required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: const TextStyle(color: blackColor),
      ),
    );
  }
}
