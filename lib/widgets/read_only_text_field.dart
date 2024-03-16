import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/colors.dart';

class ReadOnlyTextField extends StatelessWidget {
  const ReadOnlyTextField({
    super.key,
    required this.controller,
    required this.ontap,
  });

  final TextEditingController controller;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: ontap,
          child: const Icon(Icons.copy),
        ),
        fillColor: bgColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
