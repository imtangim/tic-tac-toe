import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resource/socket_methods.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = "/create-room";
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final SocketMethod socketMethod = SocketMethod();
  @override
  void initState() {
    super.initState();
    socketMethod.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadow: [
                  Shadow(
                    blurRadius: 15,
                    color: Colors.blue,
                  )
                ],
                text: "Create Room",
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _controller,
                hintext: "Enter your nickname",
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                ontap: () => socketMethod.createRoom(_controller.text.trim()),
                title: "Create",
              )
            ],
          ),
        ),
      ),
    );
  }
}
