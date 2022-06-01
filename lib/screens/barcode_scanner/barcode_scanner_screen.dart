import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/camera/camera_shape.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class BarcodeScannerScreen extends StatefulWidget {
  final Function(String) callback;

  const BarcodeScannerScreen(
      {Key? key, required this.callback})
      : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  List<String> codes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Отсканируйте  товары".toUpperCase(),
        leadingColor: const Color(0xFF28A745),
        textStyle: ThemeTextStyle.textStyle16w600,
        showLogo: false,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                if (!codes.contains(code)) {
                  codes.add(code);
                  widget.callback.call(code);
                  // context
                  //     .read<BlocGoodsList>()
                  //     .add(EventScanItem(code: code));

                }
              }
            },
          ),
          Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: CameraShaper(
                paintWidth: MediaQuery.of(context).size.width - 20,
                paintHeight: 250,
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: MediaQuery.of(context).size.width / 2 * 0.4,
            child: Center(
              child: Text(
                "Отсканируйте штрихкод товара",
                style: ThemeTextStyle.textStyle16w600
                    .copyWith(color: ColorPalette.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

