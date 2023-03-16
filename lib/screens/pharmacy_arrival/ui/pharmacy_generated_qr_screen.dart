import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PharmacyGeneratedQrScreen extends StatefulWidget {
  final PharmacyOrderDTO order;

  const PharmacyGeneratedQrScreen({super.key, required this.order})
     ;

  @override
  State<PharmacyGeneratedQrScreen> createState() =>
      _PharmacyGeneratedQrScreenState();
}

class _PharmacyGeneratedQrScreenState extends State<PharmacyGeneratedQrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'QR для подписания №${widget.order.id}'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: QrImage(
                data:
                    'mobileSign:https://tsd-aqnietgroup.kz/api/ecp/first?order_id=${widget.order.id}',),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Сканируйте QR из мобильного приложения eGov',
              style: ThemeTextStyle.textStyle18w400.copyWith(
                color: ColorPalette.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
