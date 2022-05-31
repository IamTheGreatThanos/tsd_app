import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/screens/barcode_scanner/barcode_scanner_screen.dart';
import 'package:pharmacy_arrival/screens/return_data/ui/_vmodel.dart';
import 'package:pharmacy_arrival/screens/return_data_scanned/return_data_scanned.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/toast_service.dart';

class ReturnDataScreen extends StatefulWidget {
  const ReturnDataScreen({Key? key}) : super(key: key);

  @override
  State<ReturnDataScreen> createState() => _ReturnDataScreenState();
}

class _ReturnDataScreenState extends State<ReturnDataScreen> {
  List<String> organizations = [
    "test 1",
    "test 2",
    "test 3",
  ];

  @override
  Widget build(BuildContext context) {
    final ReturnDataVModel _vmodel = context.read<ReturnDataVModel>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Возврат".toUpperCase()),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Организация",
                        style: ThemeTextStyle.textStyle14w400.copyWith(
                          color: ColorPalette.grey400,
                        ),
                      ),
                    ),
                    Flexible(child: _vmodel.organization),
                    SvgPicture.asset("assets/images/svg/chevron_right.svg"),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Контрагент",
                        style: ThemeTextStyle.textStyle14w400.copyWith(
                          color: ColorPalette.grey400,
                        ),
                      ),
                    ),
                    Flexible(child: _vmodel.counterparty),
                    SvgPicture.asset("assets/images/svg/chevron_right.svg"),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Склад с которого делается возврат",
                        style: ThemeTextStyle.textStyle14w400.copyWith(
                          color: ColorPalette.grey400,
                        ),
                      ),
                    ),
                    Flexible(child: _vmodel.stock),
                    SvgPicture.asset("assets/images/svg/chevron_right.svg"),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    AppRouter.push(
                      context,
                      BarcodeScannerScreen(
                        title: "Отсканируйте  товары".toUpperCase(),
                        callback: (code) {
                          toastServiceSuccess(code);
                          AppRouter.push(
                              context, const ReturnDataScannedScreen());
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF87615),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: const Color(0xFFd86814)),
                    ),
                    child: SvgPicture.asset("assets/images/svg/move_plus.svg"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
