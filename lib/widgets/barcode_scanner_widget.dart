import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/camera/camera_shape.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final double width;
  final double height;
  final String title;
  final double topPos;
  final Function(String) callback;
  const BarcodeScannerWidget({
    Key? key,
    required this.callback,
    required this.width,
    required this.height,
    required this.title,
    required this.topPos,
  }) : super(key: key);

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  MobileScannerController controller = MobileScannerController();
  List<String> codes = [];

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              log("BARCODE CODE::::: $code");
              if (!codes.contains(code)) {
                codes.add(code);
                widget.callback(code);
                controller.dispose();
                controller.stop();
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
              paintHeight: widget.height,
              paintWidth: widget.width,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: widget.topPos,
          child: Center(
            child: Text(
              widget.title,
              style: ThemeTextStyle.textStyle16w600
                  .copyWith(color: ColorPalette.white),
            ),
          ),
        ),
      ],
    );
  }
}
