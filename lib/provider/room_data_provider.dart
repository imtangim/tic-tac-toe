import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  //notify listener
  Map<String, dynamic> _roomData = {};
  String _scanData = "";
  Player _player1 =
      Player(nickname: "", socketID: "", points: 0.0, playerType: "X");
  Player _player2 =
      Player(nickname: "", socketID: "", points: 0.0, playerType: "O");
  List<String> _displayElement = ["", "", "", "", "", "", "", "", ""];
  int _fieldBoxes = 0;

  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;
  String get scanData => _scanData;
  List<String> get displayElement => _displayElement;
  int get fieldBoxes => _fieldBoxes;
  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateScanData(String data) {
    _scanData = data;
    notifyListeners();
  }

  void updateDisplayElement(int index, String choice) {
    _displayElement[index] = choice;
    _fieldBoxes += 1;
    notifyListeners();
  }
  void setFilledBoxesTo0() {
    _fieldBoxes = 0;
  }
}
