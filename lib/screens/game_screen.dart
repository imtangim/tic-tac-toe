import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resource/socket_methods.dart';
import 'package:tic_tac_toe/views/scoreboard.dart';
import 'package:tic_tac_toe/views/tic_tac_toe_board.dart';
import 'package:tic_tac_toe/views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = "/game";
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethod socketMethod = SocketMethod();
  @override
  void initState() {
    super.initState();
    socketMethod.updateRoomListeners(context);
    socketMethod.updatePlayerStateListeners(context);
    socketMethod.pointIncreaseListener(context);
    socketMethod.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: roomDataProvider.roomData['isJoin'] == true
          ? WaitingLoby(
              roomID: roomDataProvider.roomData["_id"],
            )
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Scoreboard(),
                  const Board(),
                  Text(
                    "${roomDataProvider.roomData['turn']['nickname']}'s turn",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
