import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resource/game_method.dart';
import 'package:tic_tac_toe/resource/socket_client.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/utils/utils.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;

  //EMITS
  void createRoom(String name) {
    if (name.isNotEmpty) {
      _socketClient.emit("room", {
        "nickname": name,
      });
    }
  }

  Socket get socketClient => _socketClient;

  void joinRoom(String nickname, String roomID, BuildContext context) {
    if (nickname.isNotEmpty && roomID.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomID': roomID,
      });
    } else {
      showSnackbar(context, "Nickname and roomID is needed");
    }
  }

  //Listeners
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on("createRoomSuccess", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on("joinRoomSuccess", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);

      Navigator.pushReplacementNamed(context, GameScreen.routeName);
    });
  }

  void errorListener(BuildContext context) {
    _socketClient.on("errorOccured", (data) {
      showSnackbar(context, data.toString());
    });
  }

  void updatePlayerStateListeners(BuildContext context) {
    _socketClient.on("updatePlayers", (playerdata) {
      log(playerdata.length.toString());
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerdata[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerdata[1]);
    });
  }

  void updateRoomListeners(BuildContext context) {
    _socketClient.on("updateRoom", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
    });
  }

  void tapGrid(int index, String roomID, List<String> displayElement) {
    if (displayElement[index] == "") {
      _socketClient.emit("tap", {
        'index': index,
        'roomID': roomID,
      });
    }
  }

  void tappedListener(BuildContext context) {
    _socketClient.on("tapped", (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElement(data["index"], data["choice"]);
      roomDataProvider.updateRoomData(data["room"]);
      GameMethod().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(
    BuildContext context,
  ) {
    _socketClient.on("pointIncrease", (playerData) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (roomDataProvider.player1.socketID == playerData['socketID']) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on("endGame", (playerData) {
      showGameDialog(context, "${playerData["nickname"]} won the game");
      Navigator.popUntil(context, (route) => false);
    });
  }
}
