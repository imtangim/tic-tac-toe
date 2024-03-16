import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/utils/utils.dart';

import '../widgets/read_only_text_field.dart';

class WaitingLoby extends StatefulWidget {
  final String roomID;

  const WaitingLoby({super.key, required this.roomID});

  @override
  State<WaitingLoby> createState() => _WaitingLobyState();
}

class _WaitingLobyState extends State<WaitingLoby> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData["_id"],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Waiting for a player to join...."),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue,
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
            ),
            child: QrImageView(
              data: Provider.of<RoomDataProvider>(context, listen: false)
                  .roomData["_id"],
              version: QrVersions.auto,
              size: 200,
              gapless: false,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.blue,
                    blurRadius: 5,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: ReadOnlyTextField(
                controller: controller,
                ontap: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text:
                          Provider.of<RoomDataProvider>(context, listen: false)
                              .roomData["_id"],
                    ),
                  ).then((value) => showSnackbar(context, "Text copied"));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
