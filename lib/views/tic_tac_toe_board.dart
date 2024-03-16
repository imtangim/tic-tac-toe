import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resource/socket_methods.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final SocketMethod _socketMethod = SocketMethod();
  void tapped(int index, RoomDataProvider provider) {
    _socketMethod.tapGrid(
      index,
      provider.roomData["_id"],
      provider.displayElement,
    );
  }

  @override
  void initState() {
    super.initState();
    _socketMethod.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, index) {
          return AbsorbPointer(
            absorbing: roomDataProvider.roomData['turn']['socketID'] !=
                _socketMethod.socketClient.id,
            child: GestureDetector(
              onTap: () => tapped(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDataProvider.displayElement[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        shadows: [
                          Shadow(
                            blurRadius: 20,
                            color: roomDataProvider.displayElement[index] == "O"
                                ? Colors.red
                                : Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
