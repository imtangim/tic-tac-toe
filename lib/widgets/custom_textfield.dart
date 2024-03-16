import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final Widget? suffix;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintext,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffix,
          fillColor: bgColor,
          filled: true,
          hintText: hintext,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
