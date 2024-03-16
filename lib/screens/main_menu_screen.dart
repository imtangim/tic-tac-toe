import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/screens/create_room_screen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = "/main-menu";
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                ontap: () =>
                    Navigator.pushNamed(context, CreateRoomScreen.routeName),
                title: "Create Room",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                ontap: () =>
                    Navigator.pushNamed(context, JoinRoomScreen.routeName),
                title: "Join Room",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
