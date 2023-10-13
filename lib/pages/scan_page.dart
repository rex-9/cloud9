import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/scan_controller.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  ScanController scanController = ScanController();

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    this.controller = controller;
    String? code;
    controller.scannedDataStream.listen((scanData) {
      if (!scanController.isScanned.value) {
        setState(() {
          result = scanData;
        });
        code = scanData.code!.split("c=").last;
        scanController.isScanned.value = true;
        if (code != null) {
          scanController.scan(code).then(
            (value) {
              scanController.isScanned.value = false;
              scanController.isLoading.value = false;
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    scanController.dispose();
    scanController.isLoading.value = false;
    super.dispose();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderWidth: 10,
                      borderLength: 20,
                      cutOutSize: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child:
                        // (result != null)
                        //     ? Text('Data: ${result!.code!.split("c=").last}')
                        //     :
                        Text('Scan a Code'),
                  ),
                )
              ],
            ),
            scanController.isLoading.value
                ? Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(40),
                      width: 150,
                      height: 150,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
