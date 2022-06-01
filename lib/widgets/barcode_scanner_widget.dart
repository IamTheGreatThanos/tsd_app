import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/camera/camera_shape.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final Function(String) callback;
  const BarcodeScannerWidget({Key? key, required this.callback})
      : super(key: key);

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  List<String> codes = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
