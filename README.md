<p align="center">
  <a href="https://github.com/imtangim/tic-tac-toe">
  </a>
  <h3 align="center">Tic-Tac-Toe -> Multiplayer with socket.io and nodejs and expressjs</h3>
</p>

<!-- HOW TO RUN -->

## How to run

Please follow the below instructions to run this project in your machine:

<p>Server section is available on ```./server``` directory.</p>

1. Clone this repository
   ```sh
   git clone https://github.com/imtangim/tic-tac-toe
   ```
2. Go into cloned directory
   ```sh
   cd tic-tac-toe
   ```
3. Install dev dependencies
   ```sh
   npm install
   ```
4. Run the app
   ```sh
   npm start
   ```
5. The server should start on in http://0.0.0.0:3000

You must configure the client socket also. To do that:

1. Goto `./lib/resources/socket_client.dart`

   Change the following code here:

   ```
   import 'package:socket_io_client/socket_io_client.dart' as IO;

    class SocketClient {
        IO.Socket? socket;
        static SocketClient? _instance;

        SocketClient._internal() {
            socket = IO.io("http://your router ip:3000", <String, dynamic>{
            "transports": ["websocket"],
            "autoConnect": false,
            });
            socket!.connect();
        }

        static SocketClient get instance {
            _instance ??= SocketClient._internal();
            return _instance!;
        }
    }
   ```

    To find your ip, `Settings -> Network & Internet -> $connected-wifi properties -> IPv4 adress`<br>

    `or`<br>

    To find your ip, on your terminal `ipconfig`

    Output:
    ```
    Wireless LAN adapter WiFi:

    Connection-specific DNS Suffix  . :
    Link-local IPv6 Address . . . . . : sample
    IPv4 Address. . . . . . . . . . . : 192.168.78.78 #this your ip addresss
    Subnet Mask . . . . . . . . . . . : 255.255.255.255
    Default Gateway . . . . . . . . . : 192.168.78.78
   ```


<strong>Note:</strong> Must run `flutter pub get` to run properly.
## Contact

<b>Tangim Haque</b>: [tanjim437@gmail.com](mailto:tanjim437@gmail.com)

<b>Portfolio</b>: [tangim.me](https://tangim.me)

<b>Project Link</b>: [https://github.com/imtangim/uptime-monitoring-api-raw-node](https://github.com/imtangim/uptime-monitoring-api-raw-node)

<b>Youtube Channel</b>: [https://youtube.com/@wittywidgets](https://youtube.com/@wittywidgets)
