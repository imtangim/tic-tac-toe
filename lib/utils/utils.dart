import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resource/game_method.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
  // ScaffoldMessenger.of(context)
  //     .showMaterialBanner(MaterialBanner(content: Text(content), actions: const []));
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                GameMethod().clearBoard(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Play Again',
              ),
            ),
          ],
        );
      });
}
