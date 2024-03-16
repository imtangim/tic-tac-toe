import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/utils/colors.dart';

class Scanner extends StatefulWidget {
  static String routeName = "/scan";
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late RoomDataProvider roomDataProvider;

  late QRViewController controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.resumeCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void didChangeDependencies() {
    roomDataProvider = Provider.of<RoomDataProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: _buildQrView(context),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text("Hold your phone"),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(
      QRViewController controller, RoomDataProvider roomDataProvider) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      roomDataProvider.updateScanData(scanData.code!);
      controller.stopCamera();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, JoinRoomScreen.routeName);
        }
      });
    });
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) =>
          _onQRViewCreated(controller, roomDataProvider),
      overlay: QrScannerOverlayShape(
          borderColor: bgColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
