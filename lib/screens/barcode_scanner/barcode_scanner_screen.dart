import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/camera/camera_shape.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  List<String> codes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Отсканируйте все товары",
        leadingColor: Color(0xFF28A745),
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

void toastServiceSuccess(String msg) {
  BotToast.showCustomText(
    duration: const Duration(seconds: 4),
    toastBuilder: (textCancel) => Align(
      alignment: const Alignment(0, -1),
      child: Container(
        width: 414,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          children: [Expanded(child: Text(msg))],
        ),
      ),
    ),
  );
}
