import 'dart:io';

import 'package:cloud9/controllers/reward_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class WithdrawScanPage extends StatefulWidget {
  final int exchangeId;
  const WithdrawScanPage({super.key, required this.exchangeId});

  @override
  State<WithdrawScanPage> createState() => _WithdrawScanPageState();
}

class _WithdrawScanPageState extends State<WithdrawScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  RewardController rewardController = RewardController();

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    this.controller = controller;
    String? shopId;
    controller.scannedDataStream.listen((scanData) {
      if (!rewardController.isScanned.value) {
        setState(() {
          result = scanData;
        });
        shopId = scanData.code;
        rewardController.isScanned.value = true;
        if (shopId != null) {
          rewardController.exchangeReward(widget.exchangeId, shopId).then(
            // rewardController.withdrawReward(widget.exchangeId, shopId).then(
            (value) {
              rewardController.isScanned.value = false;
              rewardController.isLoading.value = false;
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
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
            rewardController.isLoading.value
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
