//

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({
    super.key,
    required this.onGettingBarcode,
    this.borderColor = Colors.white,
    this.borderRadius = 10,
    this.borderLength = 30,
    this.borderWidth = 10,
    this.width = double.maxFinite,
    this.height = double.maxFinite,
  });
  final Function(String) onGettingBarcode;
  final Color borderColor;
  final double borderRadius;
  final double borderLength;
  final double borderWidth;
  final double width;
  final double height;
  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }

    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildScanView(context),
        Positioned(
          top: 10,
          child: _buildControlButtons(context),
        ),
      ],
    );
  }

  double _getScanAreaSize() {
    final shortSide = math.min(widget.width, widget.height);
    return shortSide - 112;
  }

  Widget _buildScanView(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: QRView(
        key: qrKey,
        onQRViewCreated: (controller) => onQRViewCreated(context, controller),
        overlay: QrScannerOverlayShape(
          borderColor: widget.borderColor,
          borderRadius: widget.borderRadius,
          borderLength: widget.borderLength,
          borderWidth: widget.borderWidth,
          cutOutSize: _getScanAreaSize(),
        ),
      ),
    );
  }

  Widget _buildControlButtons(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            icon: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Icon(
                    (snapshot.data!) ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
            icon: FutureBuilder<CameraFacing?>(
              future: controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return const Icon(
                    Icons.switch_camera,
                    color: Colors.white,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildResult(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        barcode != null ? 'Result: ${barcode?.code ?? ''}' : 'Scan a code',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
        maxLines: 3,
      ),
    );
  }

  void onQRViewCreated(BuildContext context, QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.pauseCamera();
    controller.resumeCamera();

    controller.scannedDataStream.listen((barcode) {
      if (barcode.code != null) {
        widget.onGettingBarcode(barcode.code!);
      }
    });
  }
}
