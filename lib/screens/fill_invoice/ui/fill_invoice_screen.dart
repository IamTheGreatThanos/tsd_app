import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_order_details_response.dart';
import 'package:pharmacy_arrival/screens/digital_signature_load/digital_signature_load_screen.dart';
import 'package:pharmacy_arrival/screens/fill_invoice/ui/_vmodel.dart';
import 'package:pharmacy_arrival/styles/color_palette.dart';
import 'package:pharmacy_arrival/utils/app_router.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';
import 'package:pharmacy_arrival/widgets/main_text_field/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../../styles/text_styles.dart';

class FillInvoiceScreen extends StatelessWidget {
  final DTOOrderDetails orderData;

  const FillInvoiceScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: orderData.orderName!.toUpperCase(),
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
                      Flexible(
                          child:
                              context.watch<FillInvoiceVModel>().incomeNumber)
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
                        controller: context
                            .watch<FillInvoiceVModel>()
                            .incomeNumberDateController,
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
                                            onPrimary: ColorPalette.white,
                                            onSurface: Colors.black,
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
                                                      color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                if (date != null) {
                                  context
                                      .read<FillInvoiceVModel>()
                                      .setIncomeNumberDate(date);
                                }
                              },
                              child: SvgPicture.asset(
                                "assets/images/svg/calendar_circle_ic.svg",
                                width: 24,
                              )),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            context.watch<FillInvoiceVModel>().bin,
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
                  Flexible(child: context.watch<FillInvoiceVModel>().recipient)
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
                    controller: context.watch<FillInvoiceVModel>().invoiceDate,
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
                                        onPrimary: ColorPalette.white,
                                        onSurface: Colors.black,
                                      ),
                                      textTheme: TextTheme(
                                        headline5:
                                            ThemeTextStyle.textTitleDella24w400,
                                        overline:
                                            ThemeTextStyle.textStyle16w600,
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
                                });
                            if (date != null) {
                              context
                                  .read<FillInvoiceVModel>()
                                  .setInvoiceDate(date);
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/svg/calendar_circle_ic.svg",
                            width: 24,
                          )),
                    ),
                  ))
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: context.read<FillInvoiceVModel>().validated ? () {
                AppRouter.push(context, DigitalSignatureLoadScreen());
              } : null,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: context.watch<FillInvoiceVModel>().validated
                      ? ColorPalette.orange
                      : ColorPalette.orangeInactive,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "ДАЛЕЕ",
                    style: ThemeTextStyle.textStyle14w600
                        .copyWith(color: ColorPalette.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
