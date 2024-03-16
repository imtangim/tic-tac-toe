import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resource/socket_methods.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = "/join-room";
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _joinNameController = TextEditingController();
  final TextEditingController _joinRoomIDController = TextEditingController();
  final SocketMethod socketMethod = SocketMethod();

  @override
  void initState() {
    super.initState();
    socketMethod.joinRoomSuccessListener(context);
    socketMethod.errorListener(context);
    socketMethod.updatePlayerStateListeners(context);
  }

  @override
  void dispose() {
    super.dispose();
    _joinNameController.dispose();
    _joinRoomIDController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateScanData("");
        didPop = true;
      },
      child: Scaffold(
        body: Responsive(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  shadow: [
                    Shadow(
                      blurRadius: 15,
                      color: Colors.blue,
                    )
                  ],
                  text: "Join Room",
                  fontSize: 70,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                CustomTextField(
                  controller: _joinNameController,
                  hintext: "Enter your nickname",
                ),
                SizedBox(
                  height: size.height * 0.045,
                ),
                CustomTextField(
                  controller: _joinRoomIDController,
                  hintext: "Enter Game ID",
                  // suffix: GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushReplacementNamed(
                  //       context,
                  //       Scanner.routeName,
                  //     );
                  //   },
                  //   child: const Icon(Icons.qr_code_scanner_rounded),
                  // ),
                ),
                SizedBox(
                  height: size.height * 0.045,
                ),
                CustomButton(
                  ontap: () => socketMethod.joinRoom(
                    _joinNameController.text,
                    _joinRoomIDController.text,
                    context,
                  ),
                  title: "Create",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
