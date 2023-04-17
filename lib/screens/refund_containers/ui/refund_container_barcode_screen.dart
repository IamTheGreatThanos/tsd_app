import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/widgets/barcode_scanner_widget.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class RefundContainerBarcodeScreen extends StatefulWidget {
  final Function(String)? onScanned;
  const RefundContainerBarcodeScreen({super.key, this.onScanned});

  @override
  State<RefundContainerBarcodeScreen> createState() =>
      _RefundContainerBarcodeScreenState();
}

class _RefundContainerBarcodeScreenState
    extends State<RefundContainerBarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Отсканируйте возвращаемый контейнер'.toUpperCase(),
        showLogo: false,
      ),
      body: SafeArea(
        child: BarcodeScannerWidget(
          hasTextField: true,
          topPos: MediaQuery.of(context).size.height / 4,
          title: 'Отсканируйте штрихкод товара',
          height: (MediaQuery.of(context).size.width - 26) / 1.5,
          width: MediaQuery.of(context).size.width - 26,
          callback: (barcode) async {
            widget.onScanned?.call(barcode);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
