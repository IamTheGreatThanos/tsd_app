import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles/color_palette.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/main_text_field/app_text_field.dart';

class FillInvoiceVModel {
  late final incomeNumber = AppTextField(
    contentPadding: EdgeInsets.zero,
    capitalize: false,
    textAlign: TextAlign.right,
    showErrorMessages: false,
  );
  late final incomeNumberDate = AppTextField(
    contentPadding: EdgeInsets.zero,
    capitalize: false,
    readonly: true,
    textAlign: TextAlign.right,
    showErrorMessages: false,
    suffixIcon: SvgPicture.asset("assets/images/svg/calendar_circle_ic.svg"),
  );
  late final bin = AppTextField(
    contentPadding: const EdgeInsets.all(12),
    hintText: "Контрагент поставщика(БИН)",
    hintStyle:
        ThemeTextStyle.textStyle14w400.copyWith(color: ColorPalette.grey400),
    keyboardType: TextInputType.number,
    showErrorMessages: false,
  );
  late final recipient = AppTextField(
    contentPadding: EdgeInsets.zero,
    capitalize: false,
    textAlign: TextAlign.right,
    showErrorMessages: false,
  );
  final TextEditingController incomeNumberDateController =
      TextEditingController();
  final TextEditingController invoiceDate = TextEditingController();

  FillInvoiceVModel();

  bool isValidated() {
    return incomeNumber.validated &&
        incomeNumberDate.validated &&
        recipient.validated &&
        incomeNumberDateController.text.isNotEmpty &&
        invoiceDate.text.isNotEmpty &&
        bin.validated;
  }
}
