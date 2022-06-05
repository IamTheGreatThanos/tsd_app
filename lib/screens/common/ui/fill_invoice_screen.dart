import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_arrival/data/model/pharmacy_order_dto.dart';
import 'package:pharmacy_arrival/data/model/warehouse_order_dto.dart';
import 'package:pharmacy_arrival/screens/common/digital_signature_load/digital_signature_load_screen.dart';
import 'package:pharmacy_arrival/screens/common/signature/signature_screen.dart';
import 'package:pharmacy_arrival/screens/common/ui/_vmodel.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:provider/provider.dart';

class FillInvoiceScreen extends StatefulWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  const FillInvoiceScreen({
    Key? key,
    this.warehouseOrder,
    this.pharmacyOrder,
    required this.isFromPharmacyPage,
  }) : super(key: key);

  @override
  State<FillInvoiceScreen> createState() => _FillInvoiceScreenState();
}

class _FillInvoiceScreenState extends State<FillInvoiceScreen> {
  TextEditingController numberController = TextEditingController();
  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final FillInvoiceVModel _vmodel = context.read<FillInvoiceVModel>();
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isFromPharmacyPage
            ? '№.${widget.pharmacyOrder?.id} ${widget.pharmacyOrder?.number}'
            : '№.${widget.warehouseOrder?.id} ${widget.warehouseOrder?.number}',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Заполните накладную",
              style: ThemeTextStyle.textTitleDella16w400,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Входящий номер",
                        style: ThemeTextStyle.textStyle14w400.copyWith(
                          color: ColorPalette.grey400,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(child: _vmodel.incomeNumber)
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Divider(
                      color: ColorPalette.borderGrey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Дата вх. номера",
                        style: ThemeTextStyle.textStyle14w400.copyWith(
                          color: ColorPalette.grey400,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        child: AppTextField(
                          contentPadding: EdgeInsets.zero,
                          capitalize: false,
                          controller: _vmodel.incomeNumberDateController,
                          readonly: true,
                          textAlign: TextAlign.right,
                          showErrorMessages: false,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                              onTap: () async {
                                final DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2019),
                                  lastDate: DateTime.now(),
                                  helpText: "Дата входящего номера",
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: ColorPalette.greyDark,
                                        ),
                                        textTheme: TextTheme(
                                          headline5: ThemeTextStyle
                                              .textTitleDella24w400,
                                          overline:
                                              ThemeTextStyle.textStyle16w600,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: Colors.black,
                                            textStyle: ThemeTextStyle
                                                .textStyle14w600
                                                .copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (date != null) {
                                  _vmodel.incomeNumberDateController.text =
                                      DateFormat("dd.MM.yyyy").format(date);
                                }
                              },
                              child: SvgPicture.asset(
                                "assets/images/svg/calendar_circle_ic.svg",
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            _vmodel.bin,
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
                  Text(
                    "Получатель",
                    style: ThemeTextStyle.textStyle14w400.copyWith(
                      color: ColorPalette.grey400,
                    ),
                  ),
                  Flexible(child: _vmodel.recipient)
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
                  Text(
                    "Дата накладной",
                    style: ThemeTextStyle.textStyle14w400.copyWith(
                      color: ColorPalette.grey400,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: AppTextField(
                      contentPadding: EdgeInsets.zero,
                      capitalize: false,
                      controller: _vmodel.invoiceDate,
                      readonly: true,
                      textAlign: TextAlign.right,
                      showErrorMessages: false,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          onTap: () async {
                            final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime.now(),
                              helpText: "Дата входящего номера",
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: ColorPalette.greyDark,
                                    ),
                                    textTheme: TextTheme(
                                      headline5:
                                          ThemeTextStyle.textTitleDella24w400,
                                      overline: ThemeTextStyle.textStyle16w600,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black,
                                        textStyle: ThemeTextStyle
                                            .textStyle14w600
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (date != null) {
                              _vmodel.invoiceDate.text =
                                  DateFormat("dd.MM.yyyy").format(date);
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/svg/calendar_circle_ic.svg",
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: ColorPalette.orange,
              disabledColor: ColorPalette.orangeInactive,
              padding: EdgeInsets.zero,
              // onTap: _vmodel.incomeNumber.validated ? () {
              //   AppRouter.push(context, DigitalSignatureLoadScreen());
              // } : null,
              ///todo

              onPressed: () {
                // if (_vmodel.incomeNumberController.text.length < 2) {
                //   print(_vmodel.incomeNumberController.text.length);
                //   buildErrorCustomSnackBar(context, 'Не все поля заполнены!!!');
                // } else {

                _bottomSheet(
                  _TypeChooseBottomSheet(
                    isFromPharmacyPage: widget.isFromPharmacyPage,
                    warehouseOrder: widget.warehouseOrder,
                    pharmacyOrder: widget.pharmacyOrder,
                  ),
                );
                // AppRouter.push(
                //   context,
                //   const DigitalSignatureLoadScreen(),
                // );
                // }
              },
              child: Center(
                child: Text(
                  "ДАЛЕЕ",
                  style: ThemeTextStyle.textStyle14w600
                      .copyWith(color: ColorPalette.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _bottomSheet(Widget widget) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return widget;
      },
    );
  }
}

class _TypeChooseBottomSheet extends StatelessWidget {
  final bool isFromPharmacyPage;
  final PharmacyOrderDTO? pharmacyOrder;
  final WarehouseOrderDTO? warehouseOrder;
  const _TypeChooseBottomSheet(
      {Key? key,
      required this.isFromPharmacyPage,
      this.pharmacyOrder,
      this.warehouseOrder,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.only(
        right: 16,
        left: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(
              top: 14,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffD9DBE9),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Выберите способ подтверждения ',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500,),
          ),
          const Spacer(),
          MaterialButton(
            height: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: ColorPalette.orange,
            disabledColor: ColorPalette.orangeInactive,
            padding: EdgeInsets.zero,
            onPressed: () {
              AppRouter.pushReplacement(
                context,
                DigitalSignatureLoadScreen(
                  isFromPharmacyPage: isFromPharmacyPage,
                  warehouseOrder: warehouseOrder,
                  pharmacyOrder: pharmacyOrder,
                ),
              );
              // }
            },
            child: Center(
              child: Text(
                "Подписать с ЭЦП",
                style: ThemeTextStyle.textStyle14w600
                    .copyWith(color: ColorPalette.white),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MaterialButton(
            height: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: ColorPalette.orange,
            disabledColor: ColorPalette.orangeInactive,
            padding: EdgeInsets.zero,
            onPressed: () {
              AppRouter.pushReplacement(
                context,
                SignatureScreen(
                  isFromPharmacyPage: isFromPharmacyPage,
                  warehouseOrder: warehouseOrder,
                  pharmacyOrder: pharmacyOrder,
                ),
              );
              // }
            },
            child: Center(
              child: Text(
                "Подписать вручную",
                style: ThemeTextStyle.textStyle14w600
                    .copyWith(color: ColorPalette.white),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
