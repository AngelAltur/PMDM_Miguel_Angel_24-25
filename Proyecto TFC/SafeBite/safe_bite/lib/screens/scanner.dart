import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}
class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(formats: const [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
    ]);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Escanear Producto')),
    body: MobileScanner(
      controller: _controller,
      onDetect: (capture) {
        for (final barcode in capture.barcodes) {
          final code = barcode.rawValue;
          if (code != null) {
            Navigator.of(context).pop(code);
            return;
          }
        }
      },
    ),
  );
}
